import 'package:clinic/Model/visit.dart';
import 'package:clinic/db.dart';
import 'package:clinic/screens/examination_receipt.dart';
import 'package:flutter/material.dart';

class ExaminationPay extends StatefulWidget {
  const ExaminationPay({Key? key}) : super(key: key);

  @override
  _ExaminationPayState createState() => _ExaminationPayState();
}

class _ExaminationPayState extends State<ExaminationPay> {
  TextEditingController _IdController = new TextEditingController();
  TextEditingController _scheduleController = new TextEditingController();
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
                  controller: _scheduleController,
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
                  controller: _IdController,
                  decoration: const InputDecoration(
                    labelText: "Enter Patient appointment Number",
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
                  controller: _IdController,
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
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: DropdownButton<String>(
                    hint: Text('Choose type of visit'),
                    items: <String>['Examination', 'Consultation']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        type = val!;
                      });
                    },
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
                        String time = DateTime.now().toString();
                        var pay = Visit(
                            fees: _feesController.text,
                            patientid: int.parse(_IdController.text),
                            scheduleid: int.parse(_scheduleController.text),
                            time: time,
                            type: type,
                            assesment: 'assesment');
                        DB.instance.insertVisit(pay);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ExaminationReceipt(
                                  fee: '80',
                                  time: time,
                                )));
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
