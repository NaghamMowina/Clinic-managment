import 'package:clinic/Model/schedule.dart';
import 'package:clinic/db.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: DB.instance.getScehdule(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      Schedule schedule = Schedule.fromMap(snapshot.data[i]);
                      return Card(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Time'),
                              Text(schedule.time),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Patient ID'),
                              Text(schedule.patientid.toString()),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}
