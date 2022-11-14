import 'package:devfestbolivia/providers/profile_provider.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:flutter/material.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/widgets/svg_image.dart';
import 'package:devfestbolivia/constants/assets_path.dart';
import 'package:devfestbolivia/screens/home/knowing_section.dart';
import 'package:devfestbolivia/screens/home/timeline_section.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
  }

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
              Text(
                TextStrings.enjoyThe,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                TextStrings.devFest,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              VerticalSpacing.xl,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingValues.l * 2,
                ),
                child: Text(
                  TextStrings.messageHome,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: DevFestColors.textBlack.withOpacity(0.6),
                      ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: SpacingValues.m * 2,
                    ),
                    renderTimeLineSection(),
                    const SizedBox(
                      height: SpacingValues.xl,
                    ),
                    renderKnowingSection(),
                    const SizedBox(
                      height: SpacingValues.l * 2,
                    )
                  ],
                ),
              ),
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
          SizedBox(
            height: SpacingValues.xl,
          ),
          SvgImage(
            pathImage: AssetsPath.googleImage,
            width: 50,
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget renderTimeLineSection() {
    return const TimelineSection();
  }

  Widget renderKnowingSection() {
    return const KnowingSection();
  }
}
