import 'package:devfestbolivia/models/validator_result.dart';
import 'package:devfestbolivia/utils/validator_util.dart';
import 'package:flutter/material.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class InputEmail extends StatefulWidget {
  final String label;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  final Function onChanged;
  final Key formKey;

  const InputEmail({
    Key? key,
    this.label = TextStrings.email,
    this.leftMargin = 0.0,
    this.rightMargin = 0.0,
    this.topMargin = 0.0,
    this.bottomMargin = 0.0,
    required this.onChanged,
    required this.formKey,
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
      child: Form(
        key: widget.formKey,
        child: TextFormField(
          onChanged: (value) => widget.onChanged(value),
          style: renderTextStyle(),
          decoration: renderInputDecoration(),
          validator: (value) {
            ValidatorResult validation = ValidatorUtil().validateEmail(value);
            return validation.message;
          },
        ),
      ),
    );
  }

  TextStyle renderTextStyle() {
    return TextStyle(
      color: DevFestColors.textInput,
      fontWeight: FontWeightValues.regular,
      fontSize: FontSizeValues.input,
    );
  }

  InputDecoration renderInputDecoration() {
    return InputDecoration(
      labelStyle: TextStyle(
        fontSize: FontSizeValues.label,
        color: DevFestColors.labelInput,
      ),
      labelText: TextStrings.email,
    );
  }
}
