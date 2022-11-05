import 'package:flutter/material.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class SectionDivider extends StatefulWidget {
  final double height;
  final double indent;

  const SectionDivider({
    Key? key,
    this.height = 0.0,
    this.indent = 20.0,
  }) : super(key: key);

  @override
  State<SectionDivider> createState() => _SectionDividerState();
}

class _SectionDividerState extends State<SectionDivider> {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: DevFestColors.separator,
      height: widget.height,
      thickness: 1,
      indent: widget.indent,
      endIndent: widget.indent,
    );
  }
}
