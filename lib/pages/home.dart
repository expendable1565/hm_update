import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_health_monitor/components/buttons.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, this.title = "lmao"});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Smart Health Monitor",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.teal),
                  child: Image(image: AssetImage("assets/indonesia.jpg")),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
                onTap: () {
                  Navigator.of(context).pushNamed("/about", arguments: "About");
                },
              ),
              ListTile(leading: Icon(Icons.feedback), title: Text("Feedback")),
              ListTile(leading: Icon(Icons.chat), title: Text("Chatbot")),
              ListTile(
                leading: Icon(Icons.group),
                title: Text("Testimonies"),
                onTap: () {
                  Navigator.of(context).pushNamed("/about", arguments: "Testimonies");
                },
              ),
              Spacer(),
              ListTile(leading: Icon(Icons.login), title: Text("Login")),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: Image(image: AssetImage("assets/appicon.jpg")),
          ),
          DecoratedImageButton(
            text: AppLocalizations.of(context)!.diagnose,
            icon: "assets/diagnose.webp",
            onPressed: () => Navigator.pushNamed(context, "/diagnose"),
            color: Colors.red,
          ),
          DecoratedImageButton(
            text: AppLocalizations.of(context)!.storage,
            icon: "assets/folder.png",
            onPressed: () => Navigator.pushNamed(context, "/storage"),
            color: Colors.orange,
          ),
          DecoratedImageButton(
            text: AppLocalizations.of(context)!.bmiCalculator,
            icon: "assets/bmi.png",
            onPressed: () => Navigator.pushNamed(context, "/bmi"),
            color: Colors.blue,
          ),
          DecoratedImageButton(
            text: AppLocalizations.of(context)!.healthyLiving,
            icon: "assets/health_diet.png",
            onPressed: () => print("Diagnose"),
            color: Colors.green,
          ),
          Text("Using language : ${Localizations.localeOf(context)}"),
        ],
      ),
    );
  }
}
