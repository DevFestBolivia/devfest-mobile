import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatefulWidget {
  final String pathImage;

  const SvgImage(this.pathImage, {super.key});

  @override
  State<SvgImage> createState() => _SvgImageState();
}

class _SvgImageState extends State<SvgImage> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      widget.pathImage,
      width: 200,
      height: 200,
      color: Colors.green,
    );
  }
}
