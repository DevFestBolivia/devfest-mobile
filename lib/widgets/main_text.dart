import 'package:devfestbolivia/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class MainText extends StatefulWidget {
  final String text;
  final Color colorText;
  final double fontSize;

  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;

  const MainText({
    Key? key,
    this.text = '',
    this.colorText = CustomColors.textInput,
    this.fontSize = 16,
    this.leftMargin = 0.0,
    this.rightMargin = 0.0,
    this.topMargin = 0.0,
    this.bottomMargin = 0.0,
  }) : super(key: key);

  @override
  State<MainText> createState() => _MainTextState();
}

class _MainTextState extends State<MainText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.leftMargin,
        right: widget.rightMargin,
        top: widget.topMargin,
        bottom: widget.bottomMargin,
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: widget.colorText,
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
