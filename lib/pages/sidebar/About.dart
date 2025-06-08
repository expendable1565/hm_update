import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutPage();
  }
}

class _AboutPage extends State<AboutPage> {
  List<Map<String, dynamic>> aboutData = [];

  void getDataFromFile(String pageName) {
    rootBundle.loadString("assets/json/sidebar_en.json").then((str) {
      Map<String, dynamic> decoded = jsonDecode(str);
      var result = List<Map<String, dynamic>>.from(decoded[pageName]);
      setState(() {
        aboutData = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    var pageRoute = ModalRoute.of(context)!.settings.arguments as String;

    getDataFromFile(pageRoute);

    return Scaffold(
      appBar: AppBar(title: Text(localizations.about)),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: aboutData.map((el) {
              TextStyle textStyle = TextStyle(fontSize: 20);
              if (el["type"] == "title") {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      el["content"],
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              return Text(el["content"]!, style: textStyle);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
