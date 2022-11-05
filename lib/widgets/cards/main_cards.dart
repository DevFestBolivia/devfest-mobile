import 'package:flutter/material.dart';
import 'package:devfestbolivia/style/spacing.dart';

class MainCards extends StatefulWidget {
  final Widget? firstPart;
  final Widget? secondPart;
  final double widthFirstPart;

  const MainCards({
    Key? key,
    required this.firstPart,
    required this.secondPart,
    this.widthFirstPart = 123,
  }) : super(key: key);

  @override
  State<MainCards> createState() => _MainCardsState();
}

class _MainCardsState extends State<MainCards> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 123,
      child: Card(
        child: Row(
          children: [
            renderFirstPart(),
            renderSecondPart(),
          ],
        ),
      ),
    );
  }

  Widget renderFirstPart() {
    return SizedBox(
      width: widget.widthFirstPart,
      height: CardsSizeValues.height,
      child: widget.firstPart,
    );
  }

  Widget renderSecondPart() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.secondPart!,
        ],
      ),
    );
  }
}
