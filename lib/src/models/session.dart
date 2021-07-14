class SessionDisplay {
  DateTime dateOfSession;
  int sessionId;
  String startTime;
  String endTime;
  bool isChoosen;
  double price;

  SessionDisplay(
      {this.dateOfSession,
      this.sessionId,
      this.startTime,
      this.endTime,
      this.isChoosen,
      this.price});

  @override
  String toString() => startTime + "-" + endTime;
}
