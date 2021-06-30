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
}
