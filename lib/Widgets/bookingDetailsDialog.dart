import 'package:flutter/material.dart';

import '../Models/bookingModel.dart';

class BookingDetailsDialog extends StatelessWidget {
  final BookingEvent booking;

  const BookingDetailsDialog({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Booking Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title: ${booking.title}'),
          Text('Car: ${booking.carMake} ${booking.carModel}'),
          Text('Customer: ${booking.customerName}'),
          Text('Mechanic: ${booking.assignedMechanic}'),
          Text('Date: ${booking.date.toLocal()}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}
