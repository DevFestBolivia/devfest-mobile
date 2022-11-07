import 'package:devfestbolivia/constants/assets_path.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleDeveloperGroupsScreen extends StatelessWidget {
  const GoogleDeveloperGroupsScreen({super.key});

  static const _dummyGdgCities = [
    'Sucre',
    'Cochabamba',
    'Tarija',
    'Santa Cruz',
    'La Paz'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: DevFestColors.primary,
        title: Text(
          TextStrings.gdg.toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: DevFestColors.primaryLight,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingValues.l,
          vertical: SpacingValues.xl,
        ),
        child: ListView(
          children: [
            _gdgCard(context),
            VerticalSpacing.l,
            Text(
              TextStrings.gdgsOnBolivia,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: _dummyGdgCities.map<Widget>((city) {
                  return Card(
                    child: Padding(
                        padding: const EdgeInsets.all(
                          SpacingValues.m,
                        ),
                        child: Column(
                          children: [
                            const SvgImage(
                              pathImage: AssetsPath.googleImage,
                              height: 24.0,
                              width: 24.0,
                            ),
                            VerticalSpacing.m,
                            Text(
                              TextStrings.gdg,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              city,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14.0),
                            )
                          ],
                        )),
                  );
                }).toList())
          ],
        ),
      ),
    );
  }

  Widget _gdgCard(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/gdg.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(SpacingValues.l),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextStrings.gdg,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                VerticalSpacing.m,
                Text(
                  TextStrings.gdgDescription,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: DevFestColors.textBlack.withOpacity(0.6)),
                ),
                VerticalSpacing.l,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () async {
                        const gdgPageUrl = 'https://devfest.gdg.com.bo';
                        if (await canLaunchUrl(Uri.parse(gdgPageUrl))) {
                          await launchUrl(Uri.parse(gdgPageUrl));
                        }
                      },
                      child: Text(
                        TextStrings.goToPage.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: DevFestColors.primary,
                            ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
