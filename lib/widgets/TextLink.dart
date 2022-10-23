import 'package:flutter/material.dart';
import 'package:devfestbolivia/constants/custom_colors.dart';

class TextLink extends StatefulWidget {
  final String firstText;
  final String linkText;
  final Function onPressed;

  const TextLink({
    Key? key,
    this.firstText = '',
    this.linkText = '',
    required this.onPressed,
  }) : super(key: key);

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.firstText,
          style: const TextStyle(fontSize: 16, color: CustomColors.textInput),
        ),
        InkWell(
            onTap: () => widget.onPressed(),
            child: Text(
              widget.linkText,
              style: const TextStyle(
                color: CustomColors.mainButton,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            )),
      ],
    );
  }
}