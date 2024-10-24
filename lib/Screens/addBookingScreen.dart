import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/bookingModel.dart';
import '../Providers/booking_provider.dart';

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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }

  Future<void> _saveBooking() async {
    if (_startDateTime == null || _endDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start and end dates')),
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
        title: const Text('Add Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(
                controller: _carMakeController, labelText: 'Car Make'),
            const SizedBox(height: 10),
            _buildTextField(
                controller: _carModelController, labelText: 'Car Model'),
            const SizedBox(height: 10),
            _buildTextField(
                controller: _carYearController,
                labelText: 'Car Year',
                inputType: TextInputType.number),
            const SizedBox(height: 10),
            _buildTextField(
                controller: _registrationPlateController,
                labelText: 'Registration Plate'),
            const SizedBox(height: 10),
            _buildTextField(
                controller: _customerNameController,
                labelText: 'Customer Name'),
            const SizedBox(height: 10),
            _buildTextField(
                controller: _customerPhoneController,
                labelText: 'Customer Phone',
                inputType: TextInputType.phone),
            const SizedBox(height: 10),
            _buildTextField(
                controller: _customerEmailController,
                labelText: 'Customer Email',
                inputType: TextInputType.emailAddress),
            const SizedBox(height: 10),
            _buildTextField(
                controller: _bookingTitleController,
                labelText: 'Booking Title'),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Start Date & Time'),
              subtitle: Text(_startDateTime != null
                  ? DateFormat.yMd().add_jm().format(_startDateTime!)
                  : 'Select start date and time'),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDateTime(context, isStart: true),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('End Date & Time'),
              subtitle: Text(_endDateTime != null
                  ? DateFormat.yMd().add_jm().format(_endDateTime!)
                  : 'Select end date and time'),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDateTime(context, isStart: false),
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField(
                controller: _mechanicController, labelText: 'Assign Mechanic'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveBooking,
              child: const Text('Save Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
