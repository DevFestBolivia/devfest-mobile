import 'package:devfestbolivia/models/sponsor.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/utils/sponsors_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorsScreen extends StatefulWidget {
  const SponsorsScreen({super.key});

  @override
  State<SponsorsScreen> createState() => _SponsorsScreenState();
}

class _SponsorsScreenState extends State<SponsorsScreen> {
  late SponsorsUtil sponsorsUtil;
  late List<Sponsor> sponsors;

  @override
  void initState() {
    sponsorsUtil = SponsorsUtil();
    sponsors = sponsorsUtil.getSponsors();
    super.initState();
  }

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
        child: ListView.separated(
          itemCount: sponsors.length,
          separatorBuilder: (context, index) => VerticalSpacing.l,
          itemBuilder: (context, index) {
            final sponsor = sponsors[index];

            return _sponsorCard(
              context,
              sponsor: sponsor,
            );
          },
        ),
      ),
    );
  }

  Widget _sponsorCard(
    BuildContext context, {
    required Sponsor sponsor,
  }) {
    return Card(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: SpacingValues.xl),
            width: 300,
            child: Image.asset(
              sponsor.localImagePath,
              fit: BoxFit.cover,
            ),
          ),
          ExpansionTile(
            title: Text(
              sponsor.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingValues.l,
                ),
                child: Text(
                  sponsor.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: DevFestColors.textBlack.withOpacity(0.6),
                      ),
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(
                bottom: SpacingValues.l,
                left: SpacingValues.l,
                right: SpacingValues.l,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () async {
                      final webPageUrl = sponsor.webUrl;

                      if (await canLaunchUrl(Uri.parse(webPageUrl))) {
                        await launchUrl(Uri.parse(webPageUrl));
                      }
                    },
                    child: Text(
                      TextStrings.goToPage.toUpperCase(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: DevFestColors.primary,
                          ),
                    )),
              )),
        ],
      ),
    );
  }
}
