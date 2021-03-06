import 'package:clinic/Model/patients.dart';
import 'package:clinic/Model/visit.dart';
import 'package:clinic/db.dart';
import 'package:clinic/screens/examination_receipt.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ExaminationPay extends StatefulWidget {
  const ExaminationPay({Key? key}) : super(key: key);

  @override
  _ExaminationPayState createState() => _ExaminationPayState();
}

class _ExaminationPayState extends State<ExaminationPay> {
  var dropdownvalue;
  TextEditingController _patientController = new TextEditingController();
  TextEditingController _feesController = new TextEditingController();
  String type = 'Examination';
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
                  controller: _patientController,
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _feesController,
                  decoration: const InputDecoration(
                    labelText: "Enter Examination fees",
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
              Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30, top: 15),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownvalue,
                    hint: Padding(
                      padding: EdgeInsets.all(1),
                      child: Text('Choose type of visit'),
                    ),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    underline: Container(
                      height: 30,
                      color: Colors.transparent,
                    ),
                    onChanged: (String? newValue) async {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                    items: ['Examination', 'Consultation']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.only(left: 1),
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                    child: SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_patientController.text.isEmpty ||
                            _feesController.text.isEmpty) {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.error(
                              message: "Please fill all fields",
                            ),
                          );
                        } else {
                          var patient = Patient(
                              patientid: int.parse(_patientController.text));
                          List checkPatients =
                              await DB.instance.checkpatientexist(patient);
                          if (checkPatients.isEmpty) {
                            showTopSnackBar(
                              context,
                              const CustomSnackBar.error(
                                message: "No Patients found with this number",
                              ),
                            );
                          } else {
                            String time = DateTime.now().toString();
                            var pay = Visit(
                                fees: _feesController.text,
                                patientId: int.parse(_patientController.text),
                                // scheduleid: int.parse(_scheduleController.text),
                                time: time,
                                type: type,
                                assesment: 'assesment');
                            int visit = await DB.instance.insertVisit(pay);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ExaminationReceipt(
                                      patientId:
                                          int.parse(_patientController.text),
                                      fee: _feesController.text,
                                      time: time,
                                      visitid: visit,
                                    )));
                          }
                        }
                      },
                      child: const Text(
                        'Pay',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(68, 147, 204, 1))),
                )),
              )
            ])));
  }
}
