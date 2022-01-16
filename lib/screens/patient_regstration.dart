import 'package:clinic/Model/patients.dart';
import 'package:clinic/db.dart';
import 'package:clinic/screens/reserve_form.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PatientRegistration extends StatefulWidget {
  const PatientRegistration({Key? key}) : super(key: key);

  @override
  _PatientRegistrationState createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

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
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Enter patient name",
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(20, 61, 102, 1)),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: "Enter patient phone",
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
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: "Enter patient age",
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_ageController.text.isEmpty ||
                            _nameController.text.isEmpty ||
                            _phoneController.text.isEmpty) {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.error(
                              message: "Fill all fields please",
                            ),
                          );
                        }

                        var patient = Patient(
                            age: int.parse(_ageController.text),
                            name: _nameController.text,
                            phone: int.parse(_phoneController.text));
                        int id = await DB.instance.insertPatient(patient);
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
                                      child:
                                          Text('Your reference number are $id'),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          primary: Colors.blue),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const ReservationForum()));
                                      },
                                      child: Text("OK")),
                                ],
                              );
                            });
                        print('reference number is $id');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(68, 147, 204, 1))),
                )),
              )
            ])));
  }
}
