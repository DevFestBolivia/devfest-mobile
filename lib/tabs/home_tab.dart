import 'package:flutter/material.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/widgets/title_text.dart';
import 'package:devfestbolivia/widgets/svg_image.dart';
import 'package:devfestbolivia/widgets/message_text.dart';
import 'package:devfestbolivia/constants/assets_path.dart';
import 'package:devfestbolivia/screens/home/knowing_section.dart';
import 'package:devfestbolivia/screens/home/timeline_section.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              renderIcon(),
              VerticalSpacing.xl,
              const TitleText(text: TextStrings.enjoyThe),
              const TitleText(text: TextStrings.devFest),
              VerticalSpacing.l,
              const MessageText(text: TextStrings.messageHome),
              renderTimeLineSection(),
              renderKnowingSection(),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget renderIcon() {
    return Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: const [
            SizedBox(height: SpacingValues.xl),
            SvgImage(pathImage: AssetsPath.googleImage, width: 50, height: 50),
          ],
        ));
  }

  Widget renderTimeLineSection() {
    return const Expanded(
      child: TimelineSection(),
    );
  }

  Widget renderKnowingSection() {
    return const Expanded(
      child: KnowingSection(),
    );
  }
}
