import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class WorkoutDisplay extends StatefulWidget {
  const WorkoutDisplay({Key? key}) : super(key: key);

  @override
  _WorkoutDisplay createState() => _WorkoutDisplay();
}

class _WorkoutDisplay extends State<WorkoutDisplay> {
  List<Widget> widgetData = [];
  var initialized = false;

  void loadWorkoutData(String dayName) {
    rootBundle.loadString("assets/json/workout_en.json").then((str) {
      List<dynamic> decoded = jsonDecode(str);
      Map<String, dynamic> data = decoded
          .where((data) => data["day"] == dayName)
          .first;
      List<dynamic> workouts = data["workouts"];
      workouts.forEach((assetName) {
        setState(() {
          widgetData.add(
            Image(image: AssetImage("assets/workout/moves/$assetName")),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as String;
    var localizations = AppLocalizations.of(context)!;

    if (!initialized) {
      initialized = true;
      loadWorkoutData(args);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(localizations.workoutSchedule)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "$args",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              ...widgetData
            ],
          ),
        ),
      ),
    );
  }
}
