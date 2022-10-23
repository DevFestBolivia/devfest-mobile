import 'package:devfestbolivia/constants/custom_colors.dart';
import 'package:flutter/material.dart';

import '../text_strings.dart';

class MainOutlinedButton extends StatefulWidget {
  final String text;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  final double marginText;
  final Function onPressed;

  const MainOutlinedButton({
    Key? key,
    this.text = TextStrings.button,
    this.leftMargin = 20.0,
    this.rightMargin = 20.0,
    this.topMargin = 0.0,
    this.bottomMargin = 0.0,
    this.marginText = 0.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<MainOutlinedButton> createState() => _MainOutlinedButtonState();
}

class _MainOutlinedButtonState extends State<MainOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.leftMargin,
        right: widget.rightMargin,
        top: widget.topMargin,
        bottom: widget.bottomMargin,
      ),
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => widget.onPressed(),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: CustomColors.mainButton, width: 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: widget.marginText),
          child: Text(widget.text,
              style: const TextStyle(
                color: CustomColors.mainButton,
                fontSize: 14,
              )),
        ),
      ),
    );
  }
}
