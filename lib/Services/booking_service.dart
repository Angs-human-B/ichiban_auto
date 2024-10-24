import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/bookingModel.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BookingEvent>> fetchBookings() async {
    try {
      final snapshot = await _firestore.collection('bookings').get();
      print(snapshot.docs.first.data());
      // print(snapshot.docs.first.data());
      print("&&&${BookingEvent.fromMap(snapshot.docs.first.data())}") ;
      return snapshot.docs.map((doc) => BookingEvent.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to load bookings: $e');
    }
  }
}
