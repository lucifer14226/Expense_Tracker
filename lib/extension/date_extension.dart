import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isToday() {
    DateTime today = DateTime.now();
    return today.year == year && today.month == month && today.day == day;
  }

  bool isYesterday() {
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.year == year &&
        yesterday.month == month &&
        yesterday.day == day;
  }

  bool isBetween(DateTime startTime, DateTime endTime) {
    return isAfter(startTime) && isBefore(endTime);
  }

  get formatedDate {
    DateFormat format;
    if (year != DateTime.now().year) {
      format = DateFormat('E, d MM yyyy');
    } else if (isToday()) {
      return 'Today';
    } else if (isYesterday()) {
      return 'Yesterday';
    } else {
      format = DateFormat('E,d MM');
    }

    return format.format(this);
  }

  get shortDate {
    DateFormat format = DateFormat('d MM');
    return format.format(this);
  }

  get simpleDate {
    return DateTime(year, month, day);
  }

  get nameofDay {
    DateFormat format = DateFormat('EEEE');
    return format.format(this);
  }

  get time {
    DateFormat format = DateFormat('HH:mm');
    return format.format(this);
  }
}
