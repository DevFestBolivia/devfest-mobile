import 'package:devfestbolivia/models/schedule.dart';

abstract class ScheduleRepository {
  Stream<List<Schedule>> getAllScheduleStream();
  Future<List<Schedule>> getAllSchedule();
  Future<List<Schedule>> getScheduleByDay();
}
