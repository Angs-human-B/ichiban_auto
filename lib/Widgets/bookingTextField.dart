import 'package:flutter/material.dart';
import 'package:ichiban_auto/common.dart';
import 'package:provider/provider.dart';
import '../Providers/booking_provider.dart';

class BookingTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;

  const BookingTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  _BookingTextFieldState createState() => _BookingTextFieldState();
}

class _BookingTextFieldState extends State<BookingTextField> {
  List<String> _filteredMechanics = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.label == 'Search Available Mechanic') {
      widget.controller.addListener(_onSearchChanged);
    }
  }

  void _onSearchChanged() {
    final query = widget.controller.text.toLowerCase();
    final mechanics =
        Provider.of<BookingProvider>(context, listen: false).availableMechanics;

    setState(() {
      _filteredMechanics = mechanics
          .where((mechanic) => mechanic.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: textGreyDark.withOpacity(.3),
              blurRadius: 0,
              spreadRadius: 0),
          const BoxShadow(
            color: Colors.white,
            spreadRadius: 0.0,
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            keyboardType: widget.label == "WorkCheckList"
                ? widget.keyboardType
                : TextInputType.multiline,
            obscureText: widget.obscureText,
            maxLines: widget.label == "WorkCheckList" ? 3 : 1,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(color: textGrey2),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            ),
          ),
          if (_filteredMechanics.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 2,
                      spreadRadius: 1),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filteredMechanics.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredMechanics[index]),
                    onTap: () {
                      widget.controller.text = _filteredMechanics[index];
                      _focusNode.unfocus();
                      _filteredMechanics.clear();
                      _focusNode.unfocus();
                      setState(() {});
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onSearchChanged);
    _focusNode.dispose();
    super.dispose();
  }
}
