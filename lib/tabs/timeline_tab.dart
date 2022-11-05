import 'package:devfestbolivia/widgets/list_sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:devfestbolivia/style/spacing.dart';

import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/models/schedule.dart';
import 'package:devfestbolivia/firebase/schedule/schedule_repository.dart';
import 'package:devfestbolivia/firebase/schedule/schedule_repository_impl.dart';

class TimelineTab extends StatefulWidget {
  const TimelineTab({Key? key}) : super(key: key);

  @override
  State<TimelineTab> createState() => _TimelineTabState();
}

class _TimelineTabState extends State<TimelineTab>
    with TickerProviderStateMixin {
  ScheduleRepository? scheduleRepository;
  bool loading = true;
  bool loadingSchedule = true;
  List<Schedule> schedules = [];
  late TabController _controller;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getSchedules();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadReferences();
    return Scaffold(
      appBar: loadingSchedule ? basicAppBar() : appBarWithTabBar(),
      body: loadingSchedule ? renderLoading() : renderTabBarView(),
    );
  }

  PreferredSizeWidget basicAppBar() {
    return AppBar(
      title: const Text(TextStrings.timeline),
      automaticallyImplyLeading: false,
    );
  }

  PreferredSizeWidget appBarWithTabBar() {
    return AppBar(
      title: const Text(TextStrings.timeline),
      bottom: renderTabBar(),
      automaticallyImplyLeading: false,
    );
  }

  PreferredSizeWidget renderTabBar() {
    return TabBar(
      controller: _controller,
      tabs: schedules.map(
        (Schedule schedule) {
          var index = schedules.indexOf(schedule);
          return Tab(text: '${TextStrings.day} ${index + 1}');
        },
      ).toList(),
    );
  }

  Widget renderTabs() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextStrings.timeline),
      ),
    );
  }

  Widget renderLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void loadReferences() {
    if (!loading) {
      return;
    }

    scheduleRepository = ScheduleRepositoryImpl();
    loading = false;
  }

  void getSchedules() async {
    schedules = await scheduleRepository!.getScheduleByDay();
    _controller = TabController(length: schedules.length, vsync: this);
    loadingSchedule = false;
    setState(() {});
  }

  Widget renderTabBarView() {
    return Container(
      margin: const EdgeInsets.all(SpacingValues.m),
      child: TabBarView(
        controller: _controller,
        children: schedules.map(
          (Schedule schedule) {
            return ListSession(schedule: schedule);
          },
        ).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
