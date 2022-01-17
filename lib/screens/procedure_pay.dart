import 'package:clinic/Model/patients.dart';
import 'package:clinic/Model/procedure.dart';
import 'package:clinic/db.dart';
import 'package:clinic/screens/procedure_receipt.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProcedurePay extends StatefulWidget {
  const ProcedurePay({Key? key}) : super(key: key);

  @override
  _ProcedurePayState createState() => _ProcedurePayState();
}

class _ProcedurePayState extends State<ProcedurePay> {
  TextEditingController _patientController = TextEditingController();
  TextEditingController _feesController = TextEditingController();
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
                    labelText: "Enter Procedure fees",
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
                padding: const EdgeInsets.all(8.0),
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
                            var pay = Procedure(
                              fees: _feesController.text,
                              patientId: int.parse(_patientController.text),
                              time: time,
                            );
                            int procedure =
                                await DB.instance.insertProcedure(pay);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProcedureReceipt(
                                      patientId:
                                          int.parse(_patientController.text),
                                      fee: _feesController.text,
                                      time: time,
                                      procedureid: procedure,
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
