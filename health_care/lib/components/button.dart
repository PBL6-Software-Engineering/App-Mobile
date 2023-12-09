import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      this.height,
      this.width,
      this.fontSize,
      required this.title,
      this.backgroundColor,
      this.foregroundColor,
      required this.onPressed,
      required this.disable})
      : super(key: key);

  final double? height;
  final double? width;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String title;
  final bool disable;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Config.primaryColor,
          foregroundColor: foregroundColor ?? Colors.white,
        ),
        onPressed: disable ? null : onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize ?? 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
