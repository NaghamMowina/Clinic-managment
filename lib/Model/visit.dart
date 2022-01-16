class Visit {
  final int? patientid;
  final int? scheduleid;
  final String time;
  final String type;
  final String assesment;
  final String fees;
  Visit(
      {this.patientid,
      this.scheduleid,
      required this.fees,
      required this.time,
      required this.type,
      required this.assesment});
  factory Visit.fromMap(Map<String, dynamic> json) => Visit(
      patientid: json['FK_patientId'],
      scheduleid: json['FK_scheduleId'],
      fees: json['fees'],
      time: json['time'],
      type: json['type'],
      assesment: json['assessment']);
  Map<String, dynamic> toMap() => {
        'FK_patientId': patientid,
        'FK_scheduleId': scheduleid,
        'fees': fees,
        'time': time,
        'type': type,
        'assessment': assesment
      };
}
