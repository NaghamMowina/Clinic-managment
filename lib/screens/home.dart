import 'package:animated_button/animated_button.dart';
import 'package:clinic/screens/examination_pay.dart';
import 'package:clinic/screens/reservation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                      builder: (BuildContext context) => const Reservation()));
                },
                child: const Text('Reserve Appointment',
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
                          const ExaminationPay()));
                },
                child: const Text('Pay Examination',
                    style:
                        TextStyle(fontFamily: 'Mochiy', color: Colors.white)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: AnimatedButton(
                onPressed: () {},
                child: const Text('Pay Procedure',
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
