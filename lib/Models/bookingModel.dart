import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingEvent extends CalendarEventData {
  final String carMake;
  final String carModel;
  final String year;
  final String registrationPlate;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String bookingTittle;
  final String startDateTime;
  final String endDateTime;
  final String assignedMechanic;

  BookingEvent({
    required super.title,
    required super.date,
    required this.carMake,
    required this.carModel,
    required this.year,
    required this.registrationPlate,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.bookingTittle,
    required this.startDateTime,
    required this.endDateTime,
    required this.assignedMechanic,
  });

  factory BookingEvent.fromMap(Map<String, dynamic> data) {
    print({
      'title': data['bookingTitle'],
      'date': DateTime.parse(data['startDateTime']),
      'carMake': data['carMake'],
      'carModel': data['carModel'],
      'year': data['year'],
      'registrationPlate': data['registrationPlate'],
      'customerName': data['customerName'],
      'customerPhone': data['customerPhone'],
      'customerEmail': data['customerEmail'],
      'bookingTittle': data['bookingTitle'],
      'startDateTime': data['startDateTime'],
      'endDateTime': data['endDateTime'],
      'assignedMechanic': data['assignedMechanic'],
    });
    return BookingEvent(
      title: data['bookingTitle'],
      date: DateTime.parse(data['startDateTime']),
      carMake: data['carMake'],
      carModel: data['carModel'],
      year: data['year'],
      registrationPlate: data['registrationPlate'],
      customerName: data['customerName'],
      customerPhone: data['customerPhone'],
      customerEmail: data['customerEmail'],
      bookingTittle: data['bookingTitle'],
      startDateTime: data['startDateTime'],
      endDateTime: data['endDateTime'],
      assignedMechanic: data['assignedMechanic'],
    );
  }
}
