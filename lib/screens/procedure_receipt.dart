import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class ProcedureReceipt extends StatelessWidget {
  final String time;
  final String fee;
  final int procedureid;
  final int patientId;
  const ProcedureReceipt(
      {Key? key,
      required this.fee,
      required this.time,
      required this.procedureid,
      required this.patientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    @override
    Future<bool> _onWillPop() async {
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(builder: (context) => Home()), (_) => false);
      return true;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Image.asset('images/receipt.jpg')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Color.fromRGBO(20, 61, 102, 1),
                ),
                child: Column(
                  children: [
                    const Center(
                        child: Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Text(
                        'Receipt',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                    _item('Time', time),
                    _item('Fee', fee),
                    _item('Procedure Id', procedureid.toString()),
                    _item('Patient Reference Number', patientId.toString()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _item(String name, String value) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
          Text(value, style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}
