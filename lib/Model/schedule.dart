class Schedule {
  final int? patientid;
  final String time;

  Schedule({
    this.patientid,
    required this.time,
  });
  factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
        patientid: json['FK_patientId'],
        time: json['time'],
      );
  Map<String, dynamic> toMap() => {
        'FK_patientId': patientid,
        'time': time,
      };
}
