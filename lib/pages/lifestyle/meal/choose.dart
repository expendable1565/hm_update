import 'package:flutter/material.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class MealButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MealButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 25, color: Colors.green[900]),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.lightGreen[100]),
      ),
    );
  }
}

class ChooseMeal extends StatefulWidget {
  const ChooseMeal({Key? key}) : super(key: key);

  @override
  _ChooseMeal createState() => _ChooseMeal();
}

class _ChooseMeal extends State<ChooseMeal> {
  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;

    widgets.clear();
    for (int i = 1; i <= 7; i++) {
      widgets.add(
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: MealButton(
              text: "${localizations.day} $i",
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed("/lifestyle/meal/display", arguments: i.toString());
              },
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.mealMenu),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/eat.jpg")),
              SizedBox(height: 8),
              ...widgets,
            ],
          ),
        ),
      ),
    );
  }
}
