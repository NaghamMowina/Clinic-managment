class Visit {
  final int? visitId;
  final int? patientId;
  final String? time;
  final String? type;
  final String? assesment;
  final String? fees;
  Visit(
      {this.visitId,
      this.fees,
      this.time,
      this.type,
      this.patientId,
      this.assesment});
  factory Visit.fromMap(Map<String, dynamic> json) => Visit(
      patientId: json['FK_patientId'],
      visitId: json['visitId'],
      fees: json['fees'],
      time: json['time'],
      type: json['type'],
      assesment: json['assessment']);
  Map<String, dynamic> toMap() => {
        'FK_patientId': patientId,
        'visitId': visitId,
        'fees': fees,
        'time': time,
        'type': type,
        'assessment': assesment
      };
}
