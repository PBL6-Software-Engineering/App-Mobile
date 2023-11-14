import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';

class DateTimeField extends StatelessWidget {
  final String? label;
  final String value;
  final bool readOnly;
  final VoidCallback? onTap;

  DateTimeField({
    this.label,
    required this.value,
    required this.readOnly,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Text(
            label!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: TextEditingController(text: value),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            prefixIcon: Icon(Icons.calendar_today),
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Config.lightBlueColor),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Config.lightBlueColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          readOnly: readOnly,
          onTap: onTap,
        ),
      ],
    );
  }
}
