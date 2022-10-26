import 'package:devfestbolivia/constants/assets_path.dart';
import 'package:devfestbolivia/widgets/cards/knowing_card.dart';
import 'package:flutter/material.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/widgets/subtitle_text.dart';

class KnowingSection extends StatefulWidget {
  const KnowingSection({Key? key}) : super(key: key);

  @override
  State<KnowingSection> createState() => _KnowingSectionState();
}

class _KnowingSectionState extends State<KnowingSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: SpacingValues.xl,
        right: SpacingValues.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubtitleText(text: TextStrings.knowing),
          renderItems(),
        ],
      ),
    );
  }

  Widget renderItems() {
    return Expanded(
      child: ListView(
        children: [
          KnowingCard(
            title: TextStrings.googleDeveloperGroups,
            imagePath: AssetsPath.googleImage,
            description: TextStrings.googleDeveloperGroupsDescription,
            onPressed: () {},
          ),
          KnowingCard(
            title: TextStrings.placesInCochabamba,
            imagePath: AssetsPath.locationOn,
            onPressed: () {},
            description: TextStrings.placesInCochambaDescription,
            widthImage: 50,
            heightImage: 50,
          ),
        ],
      ),
    );
  }
}
