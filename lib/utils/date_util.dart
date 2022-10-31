import 'package:intl/intl.dart';

class DateUtil {
  static String getDayNumber(DateTime date) {
    return date.day.toString();
  }

  static String getMinimalNameMonth(DateTime date) {
    return DateFormat('MMM').format(date);
  }

  static String getHourMinute(DateTime date) {
    return DateFormat('hh:mm').format(date);
  }

  static String getAmPm(DateTime date) {
    return DateFormat('a').format(date);
  }
}