import 'package:flutter/material.dart';

import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class SubtitleText extends StatefulWidget {
  final String text;

  const SubtitleText({Key? key, required this.text}) : super(key: key);

  @override
  State<SubtitleText> createState() => _SubtitleTextState();
}

class _SubtitleTextState extends State<SubtitleText> {
  @override
  Widget build(BuildContext context) {
    return MainText(
      text: widget.text,
      colorText: DevFestColors.textBlack,
      fountWeight: FontWeightValues.semiBold,
      fontSize: FontSizeValues.input,
    );
  }
}
