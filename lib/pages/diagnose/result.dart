import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class FunkyBar extends StatelessWidget {
  final String label;

  const FunkyBar({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    var value = Random().nextDouble() * 0.1;
    return Stack(
      children: [
        LinearProgressIndicator(value: value, minHeight: 32, color: Colors.teal,),
        SizedBox(
          height: 32,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    (value * 100).toInt().toString() + "%",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localizations.diagnose)),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 128, color: Colors.green),
            Text(
              "You are fine",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text("No diseases detected", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Disease audio matching result : "),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FunkyBar(label: "PNEUMONIA"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FunkyBar(label: "ASTHMA"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FunkyBar(label: "COPD"),
            ),
          ],
        ),
      ),
    );
  }
}
