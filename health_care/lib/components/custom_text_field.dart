import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final IconData prefixIcon;
  final bool isPassword;
  final bool isEmail;

  CustomTextField({
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.keyboardType,
    required this.prefixIcon,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      cursorColor: Config.primaryColor,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        alignLabelWithHint: true,
        prefixIcon: Icon(widget.prefixIcon),
        prefixIconColor: Config.primaryColor,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: _obscureText
                    ? Icon(
                        Icons.visibility_off_outlined,
                        color: Config.primaryColor,
                      )
                    : Icon(
                        Icons.visibility_outlined,
                        color: Config.primaryColor,
                      ),
              )
            : null,
      ),
      validator: (value) {
        if (widget.isEmail && value != null) {
          final emailRegExp = RegExp(
            r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
          );

          if (!emailRegExp.hasMatch(value)) {
            return 'Invalid email format';
          }
        }

        return null;
      },
    );
  }
}
