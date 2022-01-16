import 'package:animated_button/animated_button.dart';
import 'package:clinic/screens/patient_regstration.dart';
import 'package:clinic/screens/reserve_form.dart';
import 'package:flutter/material.dart';

class Reservation extends StatelessWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/home.jpg'),
          fit: BoxFit.cover,
        )),
        child: ListView(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
              child: Image.asset(
                "images/logo.png",
                scale: 2.5,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: AnimatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const ReservationForum()));
                },
                child: const Text('Registred Patient',
                    style:
                        TextStyle(fontFamily: 'Mochiy', color: Colors.white)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: AnimatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const PatientRegistration()));
                },
                child: const Text('New Patient',
                    style:
                        TextStyle(fontFamily: 'Mochiy', color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
