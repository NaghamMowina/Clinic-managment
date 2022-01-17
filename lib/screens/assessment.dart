import 'package:clinic/Model/visit.dart';
import 'package:clinic/db.dart';
import 'package:clinic/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Assessment extends StatefulWidget {
  const Assessment({Key? key}) : super(key: key);

  @override
  _AssessmentState createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
  TextEditingController _IdController = new TextEditingController();
  TextEditingController _assessController = new TextEditingController();
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
                    labelText: "Enter Patient Visit Number",
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
                  controller: _assessController,
                  decoration: const InputDecoration(
                    labelText: "Enter Examination Assessment",
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(20, 61, 102, 1)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_IdController.text.isEmpty ||
                            _assessController.text.isEmpty) {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.error(
                              message: "Please fill all fields",
                            ),
                          );
                        } else {
                          var visit =
                              Visit(visitId: int.parse(_IdController.text));
                          List checkPatients =
                              await DB.instance.checkVisitexist(visit);
                          if (checkPatients.isEmpty) {
                            showTopSnackBar(
                              context,
                              const CustomSnackBar.error(
                                message: "No Visits found with this number",
                              ),
                            );
                          } else {
                            var visit = Visit(
                                visitId: int.parse(_IdController.text),
                                assesment: _assessController.text);
                            DB.instance.updateAssesment(visit);
                            showTopSnackBar(
                                context,
                                const CustomSnackBar.success(
                                  message: "Inserted Assessment successfully",
                                ));
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Home()));
                          }
                        }
                      },
                      child: const Text(
                        'Insert Assessment',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(68, 147, 204, 1))),
                )),
              )
            ])));
  }
}
