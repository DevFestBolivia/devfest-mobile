import 'package:flutter/material.dart';
import 'package:devfestbolivia/custom_colors.dart';
import 'package:devfestbolivia/text_strings.dart';


class MainButton extends StatefulWidget {
  final String text;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  final Function onPressed;

  const MainButton({
    Key? key,
    this.text = TextStrings.button,
    this.leftMargin = 20.0,
    this.rightMargin = 20.0,
    this.topMargin = 0.0,
    this.bottomMargin = 0.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
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
      child: ElevatedButton(
        onPressed: () => widget.onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.mainButton,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
