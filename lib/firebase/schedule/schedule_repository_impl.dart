import 'package:devfestbolivia/models/schedule.dart';
import 'package:devfestbolivia/firebase/schedule/schedule_repository.dart';
import 'package:devfestbolivia/firebase/schedule/schedules_firestore.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final SchedulesFirestore schedulesFirestore = SchedulesFirestore();

  @override
  Stream<List<Schedule>> getAllSchedule() {
    return schedulesFirestore.getAllSchedules();
  }

  @override
  Future<List<Schedule>> getScheduleByDay() {
    return schedulesFirestore.getAllSchedulesFuture();
  }
}
