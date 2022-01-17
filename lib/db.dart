import 'package:clinic/Model/patients.dart';
import 'package:clinic/Model/procedure.dart';
import 'package:clinic/Model/schedule.dart';
import 'package:clinic/Model/visit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static final DB instance = DB._init();

  static Database? _database;

  DB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('clinic.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "create table patients(patientId integer primary key autoincrement, name varchar(50), age integer, phone integer)");
    await db.execute(
        "create table visit(visitId integer primary key autoincrement,fees text, time text, assessment text, type text,FK_patientId INTEGER,FOREIGN KEY(FK_patientId) REFERENCES patients(patientId))");
    await db.execute(
        "create table schedule(id integer primary key autoincrement, time text,FK_patientId INTEGER, FOREIGN KEY(FK_patientId) REFERENCES patients(patientId))");
    await db.execute(
        "create table procedure(procedureId integer primary key autoincrement,fees text, time text,FK_patientId INTEGER,FOREIGN KEY(FK_patientId) REFERENCES patients(patientId))");
  }

  Future _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<int> insertPatient(Patient patient) async {
    final db = await instance.database;
    return db.insert("patients", patient.toMap());
  }

  Future<int> insertVisit(Visit visit) async {
    final db = await instance.database;
    return db.insert("visit", visit.toMap());
  }

  Future<int> insertProcedure(Procedure procedure) async {
    final db = await instance.database;
    return db.insert("procedure", procedure.toMap());
  }

  Future<int> insertAppointment(Schedule schedule) async {
    final db = await instance.database;
    return db.insert("schedule", schedule.toMap());
  }

  Future<List<Schedule>> checkSchedule(Schedule schedule) async {
    final db = await instance.database;
    final result = await db
        .query('schedule', where: 'time = ?', whereArgs: [schedule.time]);
    return result.map((json) => Schedule.fromMap(json)).toList();
  }

  Future<List<Patient>> checkpatientexist(Patient patient) async {
    final db = await instance.database;
    final result = await db.query('patients',
        where: 'patientId = ?', whereArgs: [patient.patientid]);
    return result.map((json) => Patient.fromMap(json)).toList();
  }

  Future<List<Visit>> checkVisitexist(Visit visit) async {
    final db = await instance.database;
    final result = await db
        .query('visit', where: 'visitId = ?', whereArgs: [visit.visitId]);
    return result.map((json) => Visit.fromMap(json)).toList();
  }

  Future<List> getScehdule() async {
    final db = await instance.database;
    // final List<Map<String, Object?>> schedule =
    return db.query("schedule");
    //return schedule.map((e) => Schedule.fromMap(e)).toList();
  }

  Future<int> updateAssesment(Visit visit) async {
    final db = await instance.database;

    return db.update(
      'visit',
      visit.toMap(),
      where: 'visitId = ?',
      whereArgs: [visit.visitId],
    );
  }
}
