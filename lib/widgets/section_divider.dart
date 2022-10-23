import 'package:flutter/material.dart';
import 'package:devfestbolivia/constants/custom_colors.dart';

class SectionDivider extends StatefulWidget {
  final double height;

  const SectionDivider({
    Key? key,
    this.height = 0.0,
  }) : super(key: key);

  @override
  State<SectionDivider> createState() => _SectionDividerState();
}

class _SectionDividerState extends State<SectionDivider> {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: CustomColors.separator,
      height: widget.height,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}
