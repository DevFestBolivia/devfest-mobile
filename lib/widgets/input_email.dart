import 'package:flutter/material.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class InputEmail extends StatefulWidget {
  final String label;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;

  const InputEmail({
    Key? key,
    this.label = TextStrings.email,
    this.leftMargin = 0.0,
    this.rightMargin = 0.0,
    this.topMargin = 0.0,
    this.bottomMargin = 0.0,
  }) : super(key: key);

  @override
  State<InputEmail> createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.leftMargin,
        right: widget.rightMargin,
        top: widget.topMargin,
        bottom: widget.bottomMargin,
      ),
      child: const TextField(
        style: TextStyle(
          color: DevFestColors.textInput,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 20, color: DevFestColors.labelInput),
          labelText: 'Email',
        ),
      ),
    );
  }
}
