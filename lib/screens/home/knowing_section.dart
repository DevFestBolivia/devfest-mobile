import 'package:devfestbolivia/constants/assets_path.dart';
import 'package:devfestbolivia/screens/routes.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/widgets/svg_image.dart';
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
    return Column(
      children: [
        _KnowingCard(
          title: TextStrings.googleDeveloperGroups,
          imagePath: AssetsPath.googleImage,
          description: TextStrings.googleDeveloperGroupsDescription,
          onPressed: () => Navigator.pushNamed(context, Routes.GDG),
        ),
        _KnowingCard(
          title: TextStrings.placesInCochabamba,
          imagePath: AssetsPath.locationOn,
          onPressed: () => Navigator.pushNamed(context, Routes.PLACES),
          description: TextStrings.placesInCochambaDescription,
        ),
      ],
    );
  }
}

class _KnowingCard extends StatelessWidget {
  const _KnowingCard({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onPressed,
    // ignore: unused_element
    this.widthImage = 30.0,
    // ignore: unused_element
    this.heightImage = 30.0,
  });

  final String imagePath;
  final double widthImage;
  final double heightImage;
  final String title;
  final String description;
  final VoidCallback onPressed;

  final _imageWidthSection = 120.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Row(
          children: [
            Container(
              width: _imageWidthSection,
              padding: const EdgeInsets.symmetric(
                vertical: SpacingValues.xl * 2,
                horizontal: SpacingValues.l * 2,
              ),
              child: SvgImage(
                pathImage: imagePath,
                width: widthImage,
                height: heightImage,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  right: SpacingValues.xl,
                  top: SpacingValues.l * 2,
                  bottom: SpacingValues.l * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainText(
                      text: title,
                      colorText: DevFestColors.textBlack,
                      fountWeight: FontWeight.w600,
                      fontSize: FontSizeValues.input,
                    ),
                    VerticalSpacing.xxs,
                    MainText(
                      text: description,
                      colorText: DevFestColors.labelInput,
                      fountWeight: FontWeight.w600,
                      fontSize: FontSizeValues.scheduleDetail,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
