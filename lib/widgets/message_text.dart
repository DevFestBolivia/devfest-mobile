import 'package:flutter/material.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class MessageText extends StatefulWidget {
  final String text;

  const MessageText({Key? key, required this.text}) : super(key: key);

  @override
  State<MessageText> createState() => _MessageTextState();
}

class _MessageTextState extends State<MessageText> {
  @override
  Widget build(BuildContext context) {
    return MainText(
      text: widget.text,
      colorText: DevFestColors.labelInput,
      fontSize: FontSizeValues.input,
      bottomMargin: SpacingValues.xl,
      fountWeight: FontWeightValues.regular,
      leftMargin: SpacingValues.xl,
      rightMargin: SpacingValues.xl,
    );
  }
}
