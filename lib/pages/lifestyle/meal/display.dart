import 'package:flutter/material.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class MealDisplay extends StatefulWidget {
  const MealDisplay({Key? key}) : super(key: key);

  @override
  _MealDisplay createState() => _MealDisplay();
}

class _MealDisplay extends State<MealDisplay> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as String;
    var localizations = AppLocalizations.of(context)!;
    var lang = localizations.localeName == "id" ? "id" : "en";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(localizations.mealMenu)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "${localizations.day} $args",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Image(image: AssetImage("assets/meal/$lang/d${args}bf.jpg")),
              Image(image: AssetImage("assets/meal/$lang/d${args}ln.jpg")),
              Image(image: AssetImage("assets/meal/$lang/d${args}dn.jpg")),
              Image(image: AssetImage("assets/meal/$lang/d${args}sn.jpg")),
            ],
          ),
        ),
      ),
    );
  }
}
