import 'package:clinic/Model/schedule.dart';
import 'package:clinic/db.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ReservationForum extends StatefulWidget {
  const ReservationForum({Key? key}) : super(key: key);

  @override
  _ReservationForumState createState() => _ReservationForumState();
}

class _ReservationForumState extends State<ReservationForum> {
  TextEditingController _IdController = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  late String _setTime;

  late String _hour, _minute, _time = '';

  late String dateTime;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/home.jpg'),
              fit: BoxFit.cover,
            )),
            child: ListView(children: [
              Image.asset(
                "images/logo.png",
                scale: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _IdController,
                  decoration: const InputDecoration(
                    labelText: "Enter Patient Reference Number",
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(20, 61, 102, 1)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Pick date and time',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Container(
                color: Color.fromRGBO(20, 61, 102, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: IconButton(
                          onPressed: () => _selectDate(context),
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Color.fromRGBO(20, 61, 102, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        _time,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: IconButton(
                          onPressed: () => _selectTime(context),
                          icon: const Icon(
                            Icons.schedule,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () async {
                        var schedule = Schedule(
                            patientid: int.parse(_IdController.text),
                            time: selectedDate.toString() +
                                ' ' +
                                selectedTime.toString());
                        List lst = await DB.instance.checkSchedule(schedule);
                        int check;
                        print(lst);
                        if (lst.isNotEmpty) {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.error(
                              message:
                                  "It's reserved please choose another time",
                            ),
                          );
                        }
                        if (lst.isEmpty) {
                          check = await DB.instance.insertAppointment(schedule);
                          print(check);
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.success(
                              message: "Reserved successfully",
                            ),
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Your appointment number are $check'),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            primary: Colors.blue),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK")),
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text(
                        'Reserve',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(68, 147, 204, 1))),
                )),
              )
            ])));
  }
}
