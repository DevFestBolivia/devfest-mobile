import 'dart:async';

import 'package:devfestbolivia/providers/schedules_provider.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/widgets/list_sessions.dart';
import 'package:flutter/material.dart';

import 'package:devfestbolivia/style/spacing.dart';

import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/models/schedule.dart';
import 'package:provider/provider.dart';

class TimelineTab extends StatefulWidget {
  const TimelineTab({Key? key}) : super(key: key);

  @override
  State<TimelineTab> createState() => _TimelineTabState();
}

class _TimelineTabState extends State<TimelineTab>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final _selectedIndexNotifier = ValueNotifier(0);
  late Completer<bool> _setupTabsComplete;

  @override
  void initState() {
    _setupTabsComplete = Completer<bool>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('Init Schedules');
      Provider.of<SchedulesProvider>(context, listen: false).getAllSchedules();
      print('Finish Init Schedules');
      // getSchedules();
    });
    super.initState();
  }

  void _tabIndexChangedListener() {
    _selectedIndexNotifier.value = _tabController.index;
  }

  void _setupTabs() {
    final loadedSchedules = Provider.of<SchedulesProvider>(
      context,
      listen: false,
    ).schedules;
    _tabController = TabController(
      length: loadedSchedules.length,
      vsync: this,
    );
    _tabController.addListener(() {
      _selectedIndexNotifier.value = _tabController.index;
    });
    if (!_setupTabsComplete.isCompleted) {
      _setupTabsComplete.complete(true);
    }
  }

  Widget _loadingScaffold() {
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
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SchedulesProvider>(
      builder: (_, schedulesProvider, child) {
        if (schedulesProvider.state == SchedulesState.loading) {
          return _loadingScaffold();
        }

        if (schedulesProvider.state == SchedulesState.loaded) {
          _setupTabs();
          final loadedSchedules = schedulesProvider.schedules;

          return FutureBuilder<bool>(
            future: _setupTabsComplete.future,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
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
                    bottom: renderTabBar(loadedSchedules),
                  ),
                  body: renderTabBarView(loadedSchedules),
                );
              }

              return _loadingScaffold();
            },
          );
        }

        if (schedulesProvider.state == SchedulesState.failure) {
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
            ),
            body: Center(
              child: Text(
                schedulesProvider.errorMessage!,
              ),
            ),
          );
        }

        return Container();
      },
    );
  }

  PreferredSizeWidget renderTabBar(List<Schedule> schedules) {
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

  Widget renderTabBarView(List<Schedule> schedules) {
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
