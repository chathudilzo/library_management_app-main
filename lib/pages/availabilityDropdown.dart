import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AvailabilityDropdown extends StatefulWidget {
  const AvailabilityDropdown(
      {super.key, required this.initialValue, required this.onChange});
  final String initialValue;
  final Function(String) onChange;

  @override
  State<AvailabilityDropdown> createState() => _AvailabilityDropdownState();
}

class _AvailabilityDropdownState extends State<AvailabilityDropdown> {
  late String _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _value,
      onChanged: (newValue) {
        setState(() {
          _value = newValue!;
          widget.onChange(_value);
        });
      },
      items: <String>['Available', 'Checked Out']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    );
  }
}
