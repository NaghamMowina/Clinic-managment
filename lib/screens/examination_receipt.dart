import 'package:flutter/material.dart';

class ExaminationReceipt extends StatelessWidget {
  final String time;
  final String fee;
  const ExaminationReceipt({Key? key, required this.fee, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                'Receipt',
                style: TextStyle(fontSize: 20),
              ),
            )),
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
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(time, style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fee',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(fee, style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
