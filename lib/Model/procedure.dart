class Procedure {
  final int? procedureId;
  final int? patientId;
  final String? time;
  final String? fees;
  Procedure({
    this.procedureId,
    this.fees,
    this.time,
    this.patientId,
  });
  factory Procedure.fromMap(Map<String, dynamic> json) => Procedure(
        patientId: json['FK_patientId'],
        procedureId: json['procedureId'],
        fees: json['fees'],
        time: json['time'],
      );
  Map<String, dynamic> toMap() => {
        'FK_patientId': patientId,
        'procedureId': procedureId,
        'fees': fees,
        'time': time,
      };
}
