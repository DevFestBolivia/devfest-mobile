import 'package:devfestbolivia/models/schedule.dart';
import 'package:devfestbolivia/firebase/schedule/schedule_repository.dart';
import 'package:devfestbolivia/firebase/schedule/schedules_firestore.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl({
    required SchedulesFirestore schedulesFirestore,
  }) : _schedulesFirestore = schedulesFirestore;

  final SchedulesFirestore _schedulesFirestore;

  @override
  Stream<List<Schedule>> getAllScheduleStream() {
    return _schedulesFirestore.getAllSchedules();
  }

  @override
  Future<List<Schedule>> getAllSchedule() {
    return _schedulesFirestore.getAllSchedulesFuture();
  }

  @override
  Future<List<Schedule>> getScheduleByDay() {
    return _schedulesFirestore.getAllSchedulesFuture();
  }
}
