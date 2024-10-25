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
        style: TextStyle(fontSize: 26,color: textRed),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${booking.title}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Car Make: ${booking.carMake}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Car Model: ${booking.carModel}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Year: ${booking.year}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Registration Plate: ${booking.registrationPlate}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Customer Name: ${booking.customerName}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Customer Phone: ${booking.customerPhone}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Customer Email: ${booking.customerEmail}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Booking Title: ${booking.bookingTitle}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Start DateTime: ${booking.startDateTime}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'End DateTime: ${booking.endDateTime}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Assigned Mechanic: ${booking.assignedMechanic}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${booking.date.toLocal()}',
              style: const TextStyle(fontSize: 16),
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
