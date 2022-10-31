import 'package:devfestbolivia/models/schedule.dart';

abstract class ScheduleRepository {
  Stream<List<Schedule>> getAllSchedule();
  Future<List<Schedule>> getScheduleByDay();
}