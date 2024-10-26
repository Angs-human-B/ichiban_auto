import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Models/bookingModel.dart';
import '../Providers/auth_provider.dart';
import '../Widgets/calenderViewWidget.dart';
import '../Providers/booking_provider.dart';
import '../Widgets/userDrawer.dart';
import '../common.dart';

class BookingCalendarScreen extends StatefulWidget {
  const BookingCalendarScreen({super.key});

  @override
  State<BookingCalendarScreen> createState() => _BookingCalendarScreenState();
}

class _BookingCalendarScreenState extends State<BookingCalendarScreen> {
  late BookingProvider bookingProvider;
  late AuthProvider authProvider;
  bool _isInitialized = false;
  String _selectedView = 'Month';

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
    await bookingProvider.loadBookings(authProvider.user!.role,authProvider.user!.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/logo/ichibanAutoLogo.png',
          width: 390.w,
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.account_circle, size: 52.sp),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: authProvider.user?.role == "Admin"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/addBookingScreen');
              },
              backgroundColor: buttonRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 24),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ToggleButtons(
              isSelected: [
                _selectedView == 'Day',
                _selectedView == 'Week',
                _selectedView == 'Month',
              ],
              onPressed: (index) {
                setState(() {
                  _selectedView = index == 0
                      ? 'Day'
                      : index == 1
                          ? 'Week'
                          : 'Month';
                });
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Day'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Week'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Month'),
                ),
              ],
            ),
          ),
          Expanded(
            child: CalendarControllerProvider<BookingEvent>(
              controller: bookingProvider.eventController,
              child: CalendarViewWidget(
                selectedView: _selectedView,
                bookingProvider: bookingProvider,
              ),
            ),
          ),
        ],
      ),
      endDrawer: const UserDrawer(),
    );
  }
}
