import 'package:flutter/material.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/utils/validator_util.dart';

class InputPassword extends StatefulWidget {
  final String label;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  final Function onChanged;
  final Key formKey;

  const InputPassword({
    Key? key,
    this.label = TextStrings.password,
    this.leftMargin = 0.0,
    this.rightMargin = 0.0,
    this.topMargin = 0.0,
    this.bottomMargin = 0.0,
    required this.onChanged,
    required this.formKey,
  }) : super(key: key);

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _passwordVisible = true;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
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
      child: Form(
        key: widget.formKey,
        child: TextFormField(
          controller: _passwordController,
          onChanged: (value) => widget.onChanged(value),
          obscureText: !_passwordVisible,
          style: renderTextEditing(),
          decoration: renderInputDecoration(),
          validator: (value) => ValidatorUtil.validatePassword(value).message,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }

  void onEditingComplete() {
    print('onEditingComplete');
  }

  void onFieldSubmitted(String value) {
    print('onFieldSubmitted');
  }

  TextStyle renderTextEditing() {
    return TextStyle(
      color: DevFestColors.textInput,
      fontWeight: FontWeight.normal,
      fontSize: FontSizeValues.input,
    );
  }

  InputDecoration renderInputDecoration() {
    return InputDecoration(
      labelStyle: TextStyle(
        fontSize: FontSizeValues.label,
        color: DevFestColors.labelInput,
      ),
      suffixIcon: renderIconButton(),
      labelText: widget.label,
    );
  }

  Widget renderIconButton() {
    return IconButton(
      onPressed: () => showPassword(),
      icon: Icon(
        _passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: DevFestColors.textInput,
      ),
    );
  }
}
