import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ichiban_auto/common.dart';
import 'package:provider/provider.dart';

import '../Models/bookingModel.dart';
import '../Providers/auth_provider.dart';
import '../Providers/booking_provider.dart';
import '../Widgets/bookingDetailsDialog.dart';

class BookingCelenderScreen extends StatefulWidget {
  const BookingCelenderScreen({super.key});

  @override
  State<BookingCelenderScreen> createState() => _BookingCelenderScreenState();
}

class _BookingCelenderScreenState extends State<BookingCelenderScreen> {
  late BookingProvider bookingProvider;
  late AuthProvider authProvider;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      authProvider = Provider.of<AuthProvider>(context);
      bookingProvider = Provider.of<BookingProvider>(context, listen: false);
      initFunc();
      _isInitialized = true;
    }
  }

  Future<void> initFunc() async {
    await authProvider.loadUser();
    await bookingProvider.loadBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            print(bookingProvider.isLoading);
          },
          child: Text('Car Service Bookings'),
        ),
      ),
      floatingActionButton: authProvider.user?.role == "Admin"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/addBookingScreen');
              },
              backgroundColor: buttonRed,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.sp)),
              child: Icon(Icons.add, color: textFieldFill, size: 60.sp),
            )
          : null,
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
