import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class ImageButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;

  ImageButton({super.key, required this.image, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Image(image: AssetImage(image)),
    );
  }
}

class ChooseWorkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChooseWorkout();
  }
}

class _ChooseWorkout extends State<ChooseWorkout> {
  List<Widget> data = [];

  void loadWorkoutData() {
    rootBundle.loadString("assets/json/workout_en.json").then((str) {
      data = [Image(image: AssetImage("assets/allbody.jpg"))];

      List<dynamic> decoded = jsonDecode(str);
      decoded.forEach((dayData) {
        var imgName = dayData["image"] as String;
        var day = dayData["day"] as String;
        data.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ImageButton(
              image: "assets/workout/$imgName",
              onPressed: () {
                Navigator.of(context).pushNamed(
                  "/lifestyle/workout/display",
                  arguments: day
                );
              },
            ),
          ),
        );
      });
      setState(() {
        data = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    loadWorkoutData();

    return Scaffold(
      appBar: AppBar(title: Text(localizations.workoutSchedule)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [...data]),
        ),
      ),
    );
  }
}
