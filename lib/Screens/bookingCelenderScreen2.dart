import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar_view/calendar_view.dart';
import '../Models/bookingModel.dart';
import '../Widgets/bookingDetailsDialog.dart';
import '../providers/booking_provider.dart';

class BookingCelenderScreen2 extends StatefulWidget {
  const BookingCelenderScreen2({super.key});

  @override
  _BookingCelenderScreen2State createState() => _BookingCelenderScreen2State();
}

class _BookingCelenderScreen2State extends State<BookingCelenderScreen2> {
  // @override
  // void initState() {
  //   super.initState();
  //   final bookingProvider =
  //       Provider.of<BookingProvider>(context, listen: false);
  //   bookingProvider.loadBookings();
  // }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Car Service Bookings'),
      ),
      body: bookingProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : CalendarControllerProvider(
              controller: bookingProvider.eventController,
              child: MonthView(
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
