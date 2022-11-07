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
  final _mainCardElevation = 2.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _mainCardElevation,
      child: Row(
        children: [
          renderFirstPart(),
          
          widget.secondPart!
        ],
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

 
}
