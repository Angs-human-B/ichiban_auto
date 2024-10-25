import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ichiban_auto/Widgets/bookingTextField.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/bookingModel.dart';
import '../Providers/booking_provider.dart';
import '../common.dart';

class AddBookingScreen extends StatefulWidget {
  const AddBookingScreen({super.key});

  @override
  _AddBookingScreenState createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carYearController = TextEditingController();
  final _registrationPlateController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _customerEmailController = TextEditingController();
  final _bookingTitleController = TextEditingController();
  final _mechanicController = TextEditingController();

  DateTime? _startDateTime;
  DateTime? _endDateTime;

  @override
  void dispose() {
    _carMakeController.dispose();
    _carModelController.dispose();
    _carYearController.dispose();
    _registrationPlateController.dispose();
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _customerEmailController.dispose();
    _bookingTitleController.dispose();
    _mechanicController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context,
      {required bool isStart}) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final dateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        setState(() {
          if (isStart) {
            _startDateTime = dateTime;
          } else {
            _endDateTime = dateTime;
          }
        });
      }
    }
  }

  Future<void> _saveBooking() async {
    if (_startDateTime == null || _endDateTime == null||_bookingTitleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set Booking Title/start and end dates')),
      );
      return;
    }

    final booking = BookingEvent(
      title: _bookingTitleController.text.trim(),
      date: _startDateTime!,
      carMake: _carMakeController.text.trim(),
      carModel: _carModelController.text.trim(),
      year: _carYearController.text.trim(),
      registrationPlate: _registrationPlateController.text.trim(),
      customerName: _customerNameController.text.trim(),
      customerPhone: _customerPhoneController.text.trim(),
      customerEmail: _customerEmailController.text.trim(),
      bookingTitle: _bookingTitleController.text.trim(),
      startDateTime: _startDateTime!.toIso8601String(),
      endDateTime: _endDateTime!.toIso8601String(),
      assignedMechanic: _mechanicController.text.trim(),
    );

    Provider.of<BookingProvider>(context, listen: false).addBooking(booking);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/logo/ichibanAutoLogo.png',
          width: 350.w,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 15.h),
            Text(
              'Create booking for car service',
              style: TextStyle(color: textGrey1, fontSize: 42.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              '  Car details',
              style: TextStyle(color: textRed, fontSize: 32.sp),
            ),
            SizedBox(height: 6.h),
            BookingTextField(controller: _carMakeController, label: 'Make'),
            SizedBox(height: 12.h),
            BookingTextField(controller: _carModelController, label: 'Model'),
            SizedBox(height: 12.h),
            BookingTextField(controller: _carYearController, label: 'Year'),
            SizedBox(height: 12.h),
            BookingTextField(
                controller: _registrationPlateController,
                label: 'Registration Plate'),
            SizedBox(height: 16.h),
            Text(
              '  Customer details',
              style: TextStyle(color: textRed, fontSize: 32.sp),
            ),
            SizedBox(height: 6.h),
            BookingTextField(
                controller: _customerNameController, label: 'Name'),
            SizedBox(height: 12.h),
            BookingTextField(
                controller: _customerPhoneController, label: 'Phone'),
            SizedBox(height: 12.h),
            BookingTextField(
                controller: _customerEmailController, label: 'Email'),
            SizedBox(height: 16.h),
            Text(
              '  Service details',
              style: TextStyle(color: textRed, fontSize: 32.sp),
            ),
            SizedBox(height: 6.h),
            BookingTextField(
                controller: _bookingTitleController, label: 'Booking Title'),
            SizedBox(height: 12.h),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
              title:  Text('Start Date & Time',style: TextStyle(color: textGrey1, fontSize: 30.sp)),
              subtitle: Text(_startDateTime != null
                  ? DateFormat.yMd().add_jm().format(_startDateTime!)
                  : 'Select start date and time',style: TextStyle(fontSize: 25.sp)),
              trailing: IconButton(
                icon: Icon(Icons.calendar_today, color: textRed),
                onPressed: () => _selectDateTime(context, isStart: true),
              ),
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
              title: Text('End Date & Time',style: TextStyle(color: textGrey1, fontSize: 30.sp)),
              subtitle: Text(_endDateTime != null
                  ? DateFormat.yMd().add_jm().format(_endDateTime!)
                  : 'Select end date and time'
                  ,style: TextStyle(fontSize: 25.sp)),
              trailing: IconButton(
                icon: Icon(Icons.calendar_today, color: textRed),
                onPressed: () => _selectDateTime(context, isStart: false),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              '  Assign Mechanic',
              style: TextStyle(color: textRed, fontSize: 32.sp),
            ),
            SizedBox(height: 6.h),
            BookingTextField(
                controller: _mechanicController, label: 'Search Available Mechanic'),
            SizedBox(height: 30.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                backgroundColor: buttonRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.sp),
                ),
              ),
              onPressed: _saveBooking,
              child: Text('Save Booking',style: TextStyle(color: textFieldFill, fontSize: 34.sp),),
            ),
          ],
        ),
      ),
    );
  }
}
