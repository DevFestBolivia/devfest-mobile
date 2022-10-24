import 'package:devfestbolivia/style/spacing.dart';
import 'package:flutter/material.dart';

class MainCards extends StatefulWidget {
  final Widget? firstPart;
  final Widget? secondPart;

  const MainCards({
    Key? key,
    required this.firstPart,
    required this.secondPart,
  }) : super(key: key);

  @override
  State<MainCards> createState() => _MainCardsState();
}

class _MainCardsState extends State<MainCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      width: 123,
      height: CardsSizeValues.height,
      child: widget.firstPart,
    );
  }

  Widget renderSecondPart() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: CardsSizeValues.height,
        child: widget.secondPart,
      ),
    );
  }
}
