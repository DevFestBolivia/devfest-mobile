import 'package:flutter/material.dart';

import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/widgets/svg_image.dart';
import 'package:devfestbolivia/widgets/cards/main_cards.dart';

import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';

class KnowingCard extends StatefulWidget {
  final String title;
  final String description;
  final Function onPressed;
  final String imagePath;
  final double widthImage;
  final double heightImage;

  const KnowingCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onPressed,
    required this.description,
    this.widthImage = 30,
    this.heightImage = 30,
  }) : super(key: key);

  @override
  State<KnowingCard> createState() => _KnowingCardState();
}

class _KnowingCardState extends State<KnowingCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onPressed(),
      child: MainCards(
        firstPart: renderFirstPart(),
        secondPart: renderDetail(),
      ),
    );
  }

  Widget renderFirstPart() {
    return SizedBox(
      width: double.infinity,
      height: CardsSizeValues.height,
      child: Center(
        child: SvgImage(
          pathImage: widget.imagePath,
          width: widget.widthImage,
          height: widget.heightImage,
        ),
      ),
    );
  }

  Widget renderDetail() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainText(
            text: widget.title,
            colorText: DevFestColors.textBlack,
            fountWeight: FontWeight.w600,
            fontSize: FontSizeValues.input,
          ),
          MainText(
            text: widget.description,
            colorText: DevFestColors.labelInput,
            fountWeight: FontWeight.w600,
            fontSize: FontSizeValues.scheduleDetail,
          ),
        ],
      ),
    );
  }
}
