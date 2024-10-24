import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/bookingModel.dart';
import '../Providers/booking_provider.dart';
import '../Widgets/bookingDetailsDialog.dart';

class BookingCelenderScreen extends StatefulWidget {
  const BookingCelenderScreen({super.key});

  @override
  State<BookingCelenderScreen> createState() => _BookingCelenderScreenState();
}

class _BookingCelenderScreenState extends State<BookingCelenderScreen> {
  late BookingProvider bookingProvider;
  @override
  void initState() {
    super.initState();
    bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    bookingProvider.loadBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              print(bookingProvider.isLoading);
            },
            child: Text('Car Service Bookings')),
      ),
      body:
      // bookingProvider.isLoading
      //     ? const Center(child: CircularProgressIndicator())
      //     :
      CalendarControllerProvider<BookingEvent>(
              controller: bookingProvider.eventController,
              child: MonthView<BookingEvent>(
                onEventTap: (events, date) {
                  if (events.title.isNotEmpty && events.event is BookingEvent) {
                    showDialog(
                      context: context,
                      builder: (context) => BookingDetailsDialog(
                        booking: events.event as BookingEvent,
                      ),
                    );
                  }
                },
              ),
            ),
    );
  }
}
