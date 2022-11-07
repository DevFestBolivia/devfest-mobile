import 'package:devfestbolivia/style/devfest_colors.dart';
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
  late TabController _tabController;

  final _selectedIndexNotifier = ValueNotifier(0);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getSchedules();
    });
    super.initState();
  }

  void _tabIndexChangedListener() {
    _selectedIndexNotifier.value = _tabController.index;
  }

  @override
  Widget build(BuildContext context) {
    loadReferences();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DevFestColors.primary,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          TextStrings.timeline.toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: DevFestColors.primaryLight,
              ),
        ),
        bottom: loadingSchedule ? null : renderTabBar(),
        automaticallyImplyLeading: false,
      ),
      body: loadingSchedule ? renderLoading() : renderTabBarView(),
    );
  }

  PreferredSizeWidget renderTabBar() {
    return TabBar(
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      controller: _tabController,
      indicatorColor: Colors.white,
      automaticIndicatorColorAdjustment: false,
      tabs: schedules.map(
        (Schedule schedule) {
          var index = schedules.indexOf(schedule);
          return ValueListenableBuilder(
            valueListenable: _selectedIndexNotifier,
            builder: (_, selectedTabIndex, child) {
              return Tab(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  width: double.infinity,
                  height: double.infinity,
                  color: selectedTabIndex == index
                      ? Colors.white
                      : DevFestColors.primary,
                  child: Center(
                    child: Text(
                      '${TextStrings.day} ${index + 1}',
                      style: TextStyle(
                        color: selectedTabIndex == index
                            ? DevFestColors.primary
                            : DevFestColors.primaryLight.withOpacity(0.74),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
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
    _tabController = TabController(length: schedules.length, vsync: this);
    _tabController.addListener(() {
      _selectedIndexNotifier.value = _tabController.index;
    });
    loadingSchedule = false;
    setState(() {});
  }

  Widget renderTabBarView() {
    return Container(
      margin: const EdgeInsets.all(SpacingValues.m),
      child: TabBarView(
        controller: _tabController,
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
    // ignore: invalid_use_of_protected_member
    if (_tabController.hasListeners) {
      _tabController.removeListener(_tabIndexChangedListener);
    }
    _tabController.dispose();
    super.dispose();
  }
}
