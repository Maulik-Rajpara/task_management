import 'package:intl/intl.dart';

class DateTimeConverter{

  String timestampToDateTimeString(int timestampInSeconds) {
    int timestampInMilliseconds = timestampInSeconds * 1000;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour % 12;
    hour = hour == 0 ? 12 : hour;
    String formattedDateTime = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}   ${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')} $period";
    return formattedDateTime;
  }


  String convertDateTimeDisplay(dynamic date) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day;
  }

  bool isAfterTomorrow(DateTime date) {
    final afterTomorrow = DateTime.now().add(Duration(days: 2));
    return date.isAfter(afterTomorrow);
  }
}