import 'package:expat_assistant/src/utils/date_utils.dart';

class SessionDisplay {
  DateTime dateOfSession;
  DateTime startDate;
  int sessionId;
  String startTime;
  String endTime;
  bool isChoosen;
  double price;
  int status;
  bool isDisable;

  SessionDisplay(
      {this.dateOfSession, this.startDate,
      this.sessionId,
      this.startTime,
      this.endTime,
      this.isChoosen,
      this.price,
      this.status,
      this.isDisable});

  @override
  String toString() => startTime + "-" + endTime;
}
