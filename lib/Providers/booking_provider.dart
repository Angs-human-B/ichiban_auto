import 'package:calendar_view/calendar_view.dart';
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

  Future<void> loadBookings() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedBookings = await _bookingService.fetchBookings();
      _bookings = fetchedBookings;

      _eventController.removeAll(_eventController.allEvents);
      for (var booking in _bookings) {
        // _eventController.add(booking as CalendarEventData<BookingEvent>);
        _eventController.add(
          CalendarEventData<BookingEvent>(
            date: booking.date,
            event: booking,
            title: booking.bookingTittle,
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
      _eventController.add(booking as CalendarEventData<BookingEvent>);
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
}
