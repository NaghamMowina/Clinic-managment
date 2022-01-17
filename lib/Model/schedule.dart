class Schedule {
  final int? id;
  final int? patientid;
  final String time;

  Schedule({
    this.id,
    this.patientid,
    required this.time,
  });
  factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
        id: json['id'],
        patientid: json['FK_patientId'],
        time: json['time'],
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        'FK_patientId': patientid,
        'time': time,
      };
}
