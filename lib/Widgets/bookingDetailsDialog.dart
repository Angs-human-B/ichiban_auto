import 'package:flutter/material.dart';

import '../Models/bookingModel.dart';
import '../common.dart';

class BookingDetailsDialog extends StatelessWidget {
  final BookingEvent booking;

  const BookingDetailsDialog({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Booking Details',
        style: TextStyle(fontSize: 28,color: textRed),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${booking.title}',
              style: bookingDetailsTextStyle,
            ),
            const SizedBox(height: 2),
            const Divider(),
            const SizedBox(height: 2),
            Text(
              'Car Make: ${booking.carMake}',
              style: bookingDetailsTextStyle,
            ),
            Text(
              'Car Model: ${booking.carModel}',
              style: bookingDetailsTextStyle,
            ),
            Text(
              'Year: ${booking.year}',
              style: bookingDetailsTextStyle,
            ),
            Text(
              'Registration Plate: ${booking.registrationPlate}',
              style: bookingDetailsTextStyle,
            ),
            const SizedBox(height: 2),
            const Divider(),
            const SizedBox(height: 2),            Text(
              'Customer Name: ${booking.customerName}',
              style: bookingDetailsTextStyle,
            ),
            Text(
              'Customer Phone: ${booking.customerPhone}',
              style: bookingDetailsTextStyle,
            ),
            Text(
              'Customer Email: ${booking.customerEmail}',
              style: bookingDetailsTextStyle,
            ),
            const SizedBox(height: 2),
            const Divider(),
            const SizedBox(height: 2),
            Text(
              'Start DateTime: ${booking.startDateTime}',
              style: bookingDetailsTextStyle,
            ),
            Text(
              'End DateTime: ${booking.endDateTime}',
              style: bookingDetailsTextStyle,
            ),
            const SizedBox(height: 2),
            const Divider(),
            const SizedBox(height: 2),            Text(
              'Assigned Mechanic: ${booking.assignedMechanic}',
              style: bookingDetailsTextStyle,
            ),
            Text(
              'Work Details: ${booking.workCheckList}',
              style: bookingDetailsTextStyle,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Close',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );


  }
}
