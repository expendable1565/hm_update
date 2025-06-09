import 'package:flutter/material.dart';
import 'package:smart_health_monitor/components/buttons.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class ChooseLifestyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(localizations.healthyLiving)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image(image: AssetImage("assets/life.jpg"), width: 256),
            ),
            DecoratedImageButton(
              text: localizations.mealMenu,
              icon: "assets/healthy-food.png",
              onPressed: () => Navigator.pushNamed(context, "/lifestyle/meal"),
              color: Colors.green,
            ),
            DecoratedImageButton(
              text: localizations.workoutSchedule,
              icon: "assets/excercise-icon.png",
              onPressed: () => Navigator.pushNamed(context, "/lifestyle/workout"),
              color: Colors.blue,
            ),
            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
