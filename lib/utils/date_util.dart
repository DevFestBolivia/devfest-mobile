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

  static String getAmPmToStringHourMinute(String date) {
    DateTime dateTime = convertStringHHMMToDateTime(date);
    String amPm = getAmPm(dateTime);
    return amPm;
  }

  static DateTime convertStringHHMMToDateTime(String date) {
    String hour = date.substring(0, 2);
    String minute = date.substring(3, 5);
    DateTime dateTime = DateTime(2021, 1, 1, int.parse(hour), int.parse(minute));
    return dateTime;
  }
}