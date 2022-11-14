import 'package:devfestbolivia/providers/schedules_provider.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/utils/date_util.dart';
import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:flutter/material.dart';
import 'package:devfestbolivia/models/schedule.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/widgets/subtitle_text.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class TimelineSection extends StatefulWidget {
  const TimelineSection({Key? key}) : super(key: key);

  @override
  State<TimelineSection> createState() => _TimelineSectionState();
}

class _TimelineSectionState extends State<TimelineSection> {
  // ScheduleRepository? scheduleRepository;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    loadReferences();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: SpacingValues.xl,
        right: SpacingValues.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubtitleText(text: TextStrings.timeline),
          renderSchedules(),
        ],
      ),
    );
  }

  void loadReferences() {
    if (!isLoading) {
      // scheduleRepository?.getAllSchedulesFuture();
      return;
    }

    // scheduleRepository = ScheduleRepositoryImpl();
    isLoading = false;
  }

  Widget renderSchedules() {
    return StreamBuilder(
      stream: Provider.of<SchedulesProvider>(context, listen: false)
          .allSchedulesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
        return _listSchedules(snapshot);
      },
    );
  }

  Widget _listSchedules(AsyncSnapshot<List<Schedule>> schedulesSnapshot) {
    if (schedulesSnapshot.hasData && schedulesSnapshot.data != null) {
      if (schedulesSnapshot.data!.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160,
              child: LottieBuilder.asset('assets/lottie/no-data.json'),
            ),
            Text(
              TextStrings.problemLoadingData,
              style: TextStyle(
                color: Colors.blue.shade900,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }

      return Column(
        children: List.generate(
          schedulesSnapshot.data!.length,
          (index) => _ScheduleCard(
            schedule: schedulesSnapshot.data![index],
            index: index,
            // onPressed: () {},
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({
    required this.schedule,
    required this.index,
  });

  final Schedule schedule;
  final int index;

  final _cardElevation = 3.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: _cardElevation,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SpacingValues.xl * 2,
              horizontal: SpacingValues.l * 2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainText(
                  text: DateUtil.getDayNumber(schedule.date),
                  colorText: DevFestColors.primary,
                  fontSize: CardsSizeValues.day,
                  fountWeight: FontWeight.w600,
                ),
                MainText(
                  text: DateUtil.getMinimalNameMonth(schedule.date),
                  colorText: DevFestColors.primary,
                  fontSize: CardsSizeValues.month,
                  fountWeight: FontWeight.w600,
                )
              ],
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
                    text: '${TextStrings.day} ${index + 1}',
                    colorText: DevFestColors.textBlack,
                    fountWeight: FontWeight.w600,
                    fontSize: FontSizeValues.input,
                  ),
                  VerticalSpacing.xxs,
                  MainText(
                    text: schedule.tracks.first.title,
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
    );
  }
}
