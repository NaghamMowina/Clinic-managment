class Patient {
  final int? patientid;
  final String? name;
  final int? age;
  final int? phone;
  Patient({this.patientid, this.age, this.name, this.phone});
  factory Patient.fromMap(Map<String, dynamic> json) => Patient(
      patientid: json['patientId'],
      name: json['name'],
      age: json['age'],
      phone: json['phone']);
  Map<String, dynamic> toMap() =>
      {'patientId': patientid, 'name': name, 'age': age, 'phone': phone};
}
