import 'package:flutter/material.dart';
import 'package:smart_health_monitor/components/buttons.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class DiagnoseChoose extends StatelessWidget {
  const DiagnoseChoose({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.diagnose)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.chooseBody,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32,),
            ),
            SizedBox(width: 10, height: 20),
            DecoratedImageButton(
              text: AppLocalizations.of(context)!.frontLungs,
              icon: "assets/lung.png",
              onPressed: () => Navigator.pushNamed(context, "/diagnose/lung", arguments: "FrontLungs"),
              color: Colors.red,
            ),
            DecoratedImageButton(
              text: AppLocalizations.of(context)!.backLungs,
              icon: "assets/lung.png",
              onPressed: () => Navigator.pushNamed(context, "/diagnose/lung", arguments: "BackLungs"),
              color: Colors.red,
            ),
            DecoratedImageButton(
              text: AppLocalizations.of(context)!.heartRate,
              icon: "assets/heart_rate.png",
              onPressed: () => Navigator.pushNamed(context, "/diagnose/heart"),
              color: Colors.red,
            ),
            SizedBox(width: 10, height: 100,)
          ],
        ),
      ),
    );
  }
}
