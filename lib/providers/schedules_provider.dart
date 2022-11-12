import 'package:devfestbolivia/firebase/schedule/schedule_repository.dart';
import 'package:devfestbolivia/models/schedule.dart';
import 'package:flutter/material.dart';

enum SchedulesState {
  initial,
  loading,
  failure,
  loaded,
}

class SchedulesProvider extends ChangeNotifier {
  SchedulesProvider({
    required ScheduleRepository scheduleRepository,
  }) : _schedulesRepository = scheduleRepository;

  final ScheduleRepository _schedulesRepository;

  SchedulesState state = SchedulesState.initial;
  List<Schedule>? schedules;
  String? errorMessage;

  void getAllSchedules() async {
    try {
      state = SchedulesState.loading;
      notifyListeners();
      schedules = await _schedulesRepository.getAllSchedule();

      if (schedules!.isEmpty) {
        throw Exception('Empty schedules');
      }

      state = SchedulesState.loaded;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      state = SchedulesState.failure;
      notifyListeners();
    }
  }

  Stream<List<Schedule>> get allSchedulesStream =>
      _schedulesRepository.getAllScheduleStream();
}
