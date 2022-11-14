import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatefulWidget {
  final String pathImage;
  final double width;
  final double height;

  const SvgImage({
    super.key,
    required this.pathImage,
    this.width = 200,
    this.height = 200,
  });

  @override
  State<SvgImage> createState() => _SvgImageState();
}

class _SvgImageState extends State<SvgImage> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      widget.pathImage,
      width: widget.width,
      height: widget.height,
    );
  }
}
