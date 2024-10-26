import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/bookingModel.dart';
import '../Providers/booking_provider.dart';
import '../Widgets/bookingDetailsDialog.dart';

class CalendarViewWidget extends StatelessWidget {
  final String selectedView;
  final BookingProvider bookingProvider;

  const CalendarViewWidget({
    Key? key,
    required this.selectedView,
    required this.bookingProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (selectedView) {
      case 'Day':
        return DayView<BookingEvent>(
          controller: bookingProvider.eventController,
          headerStyle: const HeaderStyle(
            decoration: BoxDecoration(color: Colors.white),
          ),
          onEventTap: (List<CalendarEventData<Object?>> events, DateTime date) {
            if (events.isNotEmpty && events[0] is CalendarEventData<BookingEvent>) {
              final bookingEvent = events[0] as CalendarEventData<BookingEvent>;
              showDialog(
                context: context,
                builder: (context) => BookingDetailsDialog(
                  booking: bookingEvent.event as BookingEvent,
                ),
              );
            }
          },
        );

      case 'Week':
        return WeekView<BookingEvent>(
          controller: bookingProvider.eventController,
          startDay: WeekDays.sunday,
          headerStyle: const HeaderStyle(
            decoration: BoxDecoration(color: Colors.white),
          ),
          onEventTap: (List<CalendarEventData<Object?>> events, DateTime date) {
            if (events.isNotEmpty && events[0] is CalendarEventData<BookingEvent>) {
              final bookingEvent = events[0] as CalendarEventData<BookingEvent>;
              showDialog(
                context: context,
                builder: (context) => BookingDetailsDialog(
                  booking: bookingEvent.event as BookingEvent,
                ),
              );
            }
          },
        );

      case 'Month':
      default:
        return MonthView<BookingEvent>(
          onEventTap: (events, date) {
            showDialog(
              context: context,
              builder: (context) => BookingDetailsDialog(
                booking: events.event as BookingEvent,
              ),
            );
          },
          startDay: WeekDays.sunday,
          headerStyle: const HeaderStyle(
            decoration: BoxDecoration(color: Colors.white),
          ),
        );
    }
  }
}
