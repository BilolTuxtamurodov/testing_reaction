class ResultData {
  DateTime? startedTime;
  DateTime? finishedTime;

  ResultData({this.startedTime, this.finishedTime});

  @override
  String toString() {
    return 'ResultData{startedTime: $startedTime, finishedTime: $finishedTime}';
  }
}