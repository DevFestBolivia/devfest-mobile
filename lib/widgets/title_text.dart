import 'package:flutter/material.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class TitleText extends StatefulWidget {
  final String text;

  const TitleText({Key? key,  required this.text}) : super(key: key);

  @override
  State<TitleText> createState() => _TitleTextState();
}

class _TitleTextState extends State<TitleText> {
  @override
  Widget build(BuildContext context) {
    return MainText(
      text: widget.text,
      colorText: DevFestColors.textBlack,
      fontSize: FontSizeValues.title,
      fountWeight: FontWeightValues.semiBold,
    );
  }
}
