import 'package:flutter/material.dart';
import 'package:devfestbolivia/constants/custom_colors.dart';
import 'package:devfestbolivia/text_strings.dart';

class InputPassword extends StatefulWidget {
  final String label;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;

  const InputPassword({
    Key? key,
    this.label = TextStrings.password,
    this.leftMargin = 0.0,
    this.rightMargin = 0.0,
    this.topMargin = 0.0,
    this.bottomMargin = 0.0,
  }) : super(key: key);

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  void showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.leftMargin,
        right: widget.rightMargin,
        top: widget.topMargin,
        bottom: widget.bottomMargin,
      ),
      child: TextField(
        obscureText: !_passwordVisible,
        style: const TextStyle(
          color: CustomColors.textInput,
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 20, color: CustomColors.labelInput),
          suffixIcon: IconButton(
            onPressed: () => showPassword(),
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: CustomColors.textInput,
            ),
          ),
          labelText: widget.label,
        ),
      ),
    );
  }
}
