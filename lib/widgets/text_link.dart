import 'package:flutter/material.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class TextLink extends StatelessWidget {
  const TextLink({
    required this.onPressed,
    Key? key,
    this.firstText = '',
    this.linkText = '',
    this.activateUnderline = false,
  }) : super(key: key);

  final String firstText;
  final String linkText;
  final Function onPressed;
  final bool activateUnderline;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          firstText,
          style: TextStyle(
            fontSize: FontSizeValues.input,
            color: DevFestColors.textInput,
          ),
        ),
        InkWell(
          onTap: () => onPressed(),
          child: Text(
            linkText,
            style: TextStyle(
              color: DevFestColors.primary,
              decoration: activateUnderline ? TextDecoration.underline : null,
              fontWeight: FontWeight.w500,
              fontSize: FontSizeValues.input,
            ),
          ),
        ),
      ],
    );
  }
}
