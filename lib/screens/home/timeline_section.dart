import 'package:flutter/material.dart';
import 'package:devfestbolivia/models/schedule.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/widgets/subtitle_text.dart';
import 'package:devfestbolivia/widgets/cards/schedule_card.dart';
import 'package:devfestbolivia/firebase/schedule/schedule_repository.dart';
import 'package:devfestbolivia/firebase/schedule/schedule_repository_impl.dart';

class TimelineSection extends StatefulWidget {
  const TimelineSection({Key? key}) : super(key: key);

  @override
  State<TimelineSection> createState() => _TimelineSectionState();
}

class _TimelineSectionState extends State<TimelineSection> {
  ScheduleRepository? scheduleRepository;
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

    scheduleRepository = ScheduleRepositoryImpl();
    isLoading = false;
  }

  Widget renderSchedules() {
    return StreamBuilder(
      stream: scheduleRepository?.getAllSchedule(),
      builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
        return _listSchedules(snapshot);
      },
    );
  }

  Widget _listSchedules(AsyncSnapshot<List<Schedule>> snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return ScheduleCard(
              schedule: snapshot.data![index],
              index: index,
              onPressed: () {},
            );
          },
        ),
      );
    } else {
      return const Text('No data');
    }
  }
}
