import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/bookingModel.dart';
import '../Services/booking_service.dart';

class BookingProvider with ChangeNotifier {
  final BookingService _bookingService = BookingService();
  final EventController<BookingEvent> _eventController = EventController<BookingEvent>();

  EventController<BookingEvent> get eventController => _eventController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<BookingEvent> _bookings = [];
  List<BookingEvent> get bookings => _bookings;

  List<String> _availableMechanics = [];
  List<String> get availableMechanics => _availableMechanics;

  Future<void> loadBookings(String userRole, String userName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedBookings = await _bookingService.fetchBookings();

      // Filter
      if (userRole == 'Mechanic') {
        _bookings = fetchedBookings.where((booking) => booking.assignedMechanic == userName).toList();
      } else {
        _bookings = fetchedBookings; // Admin can see all bookings
      }

      _eventController.removeAll(_eventController.allEvents);
      for (var booking in _bookings) {
        _eventController.add(
          CalendarEventData<BookingEvent>(
            date: booking.date,
            event: booking,
            title: booking.bookingTitle,
            startTime: DateTime.parse(booking.startDateTime),
            endTime: DateTime.parse(booking.endDateTime),
            description: booking.title,
          ),
        );
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error loading bookings: $e');
    } finally {
      print("loadBookings Done");
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> addBooking(BookingEvent booking) async {
    try {
      // Add to Firestore
      await _bookingService.addBookingToFirestore(booking);

      //local state
      _eventController.add(
        CalendarEventData<BookingEvent>(
          date: booking.date,
          event: booking,
          title: booking.bookingTitle,
          startTime: DateTime.parse(booking.startDateTime),
          endTime: DateTime.parse(booking.endDateTime),
          description: booking.title,
        ),
      );

      _bookings.add(booking);
      notifyListeners();
    } catch (e) {
      print('Error adding booking: $e');
    }
  }

  void removeBooking(BookingEvent booking) {
    _eventController.remove(booking as CalendarEventData<BookingEvent>);
    _bookings.remove(booking);
    notifyListeners();
  }

  void updateBooking(BookingEvent oldBooking, BookingEvent updatedBooking) {
    _eventController.update(oldBooking as CalendarEventData<BookingEvent>, updatedBooking as CalendarEventData<BookingEvent>);

    final index = _bookings.indexOf(oldBooking);
    if (index != -1) {
      _bookings[index] = updatedBooking;
      notifyListeners();
    }
  }
  Future<void> fetchAvailableMechanics() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Mechanic')
          .get();

      _availableMechanics = snapshot.docs
          .map((doc) => doc.data()['name'] as String)
          .toList();

      notifyListeners();
    } catch (e) {
      print('Failed to fetch mechanics: $e');
    }
  }
}
