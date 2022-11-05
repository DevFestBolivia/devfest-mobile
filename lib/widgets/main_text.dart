import 'package:flutter/material.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class MainText extends StatefulWidget {
  final String text;
  final Color colorText;
  final double fontSize;
  final FontWeight fountWeight;

  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;

  final bool expandableText;

  const MainText({
    Key? key,
    this.text = '',
    this.colorText = DevFestColors.textInput,
    this.fontSize = 16,
    this.leftMargin = 0.0,
    this.rightMargin = 0.0,
    this.topMargin = 0.0,
    this.bottomMargin = 0.0,
    this.fountWeight = FontWeight.w400,
    this.expandableText = false,
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
      child: widget.expandableText ? renderExpandableText() : renderText(),
    );
  }

  Widget renderText() {
    return Text(
      widget.text,
      style: TextStyle(
        color: widget.colorText,
        fontSize: widget.fontSize,
        fontWeight: widget.fountWeight,
      ),
    );
  }

  Widget renderExpandableText() {
    return Text(
      widget.text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: widget.colorText,
        fontSize: widget.fontSize,
        fontWeight: widget.fountWeight,
      ),
    );
  }
}
