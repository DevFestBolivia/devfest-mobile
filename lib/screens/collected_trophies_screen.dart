import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CollectedTrophiesScreen extends StatefulWidget {
  const CollectedTrophiesScreen({
    required this.profile,
    super.key,
  });

  final Profile profile;

  @override
  State<CollectedTrophiesScreen> createState() =>
      _CollectedTrophiesScreenState();
}

class _CollectedTrophiesScreenState extends State<CollectedTrophiesScreen> {
  double scoreForAchievements = 0.0;

  @override
  void initState() {
    for (var scan in widget.profile.qrDynamicScans) {
      scoreForAchievements += scan.score;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          TextStrings.achievementsObtained.toUpperCase(),
          style: const TextStyle(
            color: DevFestColors.textBlack,
          ),
        ),
        iconTheme: const IconThemeData(
          color: DevFestColors.textBlack,
        ),
        backgroundColor: DevFestColors.primaryLight,
        shadowColor: DevFestColors.transparent,
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 160,
                width: 160,
                child: LottieBuilder.asset('assets/lottie/trophy.json'),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      VerticalSpacing.xxl,
                      Text(
                        '${widget.profile.qrDynamicScans.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SpacingValues.l,
                          color: DevFestColors.primary,
                        ),
                      ),
                      const Text(
                        'Logros escaneados',
                      ),
                      VerticalSpacing.m,
                      Text(
                        '$scoreForAchievements',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SpacingValues.l,
                          color: DevFestColors.primary,
                        ),
                      ),
                      const Text('Puntaje obtenido con logros'),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: widget.profile.qrDynamicScans.isEmpty
                ? const Center(
                    child: Text('Sin logros conseguidos, aún'),
                  )
                : ListView.separated(
                    itemCount: widget.profile.qrDynamicScans.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 0,
                      );
                    },
                    itemBuilder: (context, index) {
                      final QrDynamicScan qrDynamicScan =
                          widget.profile.qrDynamicScans[index];
                      return ListTile(
                        title: Text(qrDynamicScan.value),
                        subtitle: Text('Score: ${qrDynamicScan.score}'),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
