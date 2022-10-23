import 'package:flutter/material.dart';

class LocalImage extends StatefulWidget {
  final String pathImage;
  final double horizontalMargin;
  final double verticalMargin;

  const LocalImage({
    Key? key,
    required this.pathImage,
    this.horizontalMargin = 0.0,
    this.verticalMargin = 0.0,
  }) : super(key: key);

  @override
  State<LocalImage> createState() => _LocalImageState();
}

class _LocalImageState extends State<LocalImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: widget.horizontalMargin,
        vertical: widget.verticalMargin,
      ),
      child: Image(image: AssetImage(widget.pathImage)),
    );
  }
}
