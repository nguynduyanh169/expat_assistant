import 'package:intl/intl.dart';

class DateTimeUtils {
  String getStartMonthText({List<int> startDateTime}) {
    int month = startDateTime[1];

    switch (month) {
      case 1:
        return 'Jan';
        break;
      case 2:
        return 'Feb';
        break;
      case 3:
        return 'Mar';
        break;
      case 4:
        return 'Apr';
        break;
      case 5:
        return 'May';
        break;
      case 6:
        return 'Jun';
        break;
      case 7:
        return 'Jul';
        break;
      case 8:
        return 'Aug';
        break;
      case 9:
        return 'Sep';
        break;
      case 10:
        return 'Oct';
        break;
      case 11:
        return 'Now';
        break;
      case 12:
        return 'Dec';
        break;
      default:
        return 'N/A';
        break;
    }
  }

  int getStartDay({List<int> startDateTime}) {
    int day = startDateTime[2];
    return day;
  }

  String getStartEndHour({List<int> startDateTime, List<int> endDateTime}) {
    String startTime = startDateTime[3].toString().padLeft(2, '0') +
        ":" +
        startDateTime[4].toString().padLeft(2, '0');
    String endTime = endDateTime[3].toString().padLeft(2, '0') +
        ":" +
        endDateTime[4].toString().padLeft(2, '0');

    return startTime + " - " + endTime;
  }

  String getDateTimeForDetails({List<int> startDateTime}) {
    DateTime _date =
        DateTime(startDateTime[0], startDateTime[1], startDateTime[2]);
    return DateFormat.yMMMMd().format(_date);
  }

  String getDateTimeForNews({List<int> startDateTime}) {
    DateTime _date = DateTime(startDateTime[0], startDateTime[1],
        startDateTime[2], startDateTime[3], startDateTime[4]);
    return DateFormat("dd/MM/yyyy HH:mm").format(_date);
  }

  int caculateDays({List<int> date}) {
    DateTime _date = DateTime(date[0], date[1], date[2], date[3], date[4]);
    DateTime to = DateTime.now();
    return (to.difference(_date).inHours / 24).round();
  }

  String getTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  String getDateTimeAppointment(List<int> startDate, List<int> endDate) {
    DateTime _date = DateTime(startDate[0], startDate[1], startDate[2]);
    DateTime _startDate = DateTime(
        startDate[0], startDate[1], startDate[2], startDate[3], startDate[4]);
    DateTime _endDate =
        DateTime(endDate[0], endDate[1], endDate[2], endDate[3], endDate[4]);
    String date = DateFormat.yMMMMd('en_US').format(_date);
    String result = date + " " + getTime(_startDate) + "-" + getTime(_endDate);
    return result;
  }
}
