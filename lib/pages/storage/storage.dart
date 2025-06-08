import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_health_monitor/components/FileParser.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';
import 'package:path/path.dart';

class StorageContainer extends StatefulWidget {
  var files = ["Hello", "World"];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StorageContainer();
  }
}

class _StorageContainer extends State<StorageContainer> {
  var files = ["Loading..."];

  Future<String> getDownloadPath() async {
    var perms = await Permission.storage.status;
    if (perms.isDenied) {
      await Permission.storage.request();
    }
    var downloads = await getApplicationDocumentsDirectory();
    var usageFolder = Directory("${downloads.path}/Recordings");
    if (!await usageFolder.exists()) {
      await usageFolder.create();
    }
    return usageFolder.path;
  }

  void updateFiles() async {
    var directory = await getDownloadPath();
    var folder = Directory(directory);
    var currentFiles = folder.listSync().map((ent) => ent.path).toList();
    if (!mounted) {
      return;
    }
    setState(() {
      files = currentFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    updateFiles();

    var nameMappings = {
      "FrontLungs": AppLocalizations.of(context)!.frontLungs,
      "BackLungs": AppLocalizations.of(context)!.backLungs,
    };

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.storage)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: files
                .map((str) {
                  var decodedString = FileParser.toDisplayString(
                    FileParser.decode(str),
                    AppLocalizations.of(context)!
                  );

                  if (decodedString.length == 0) {
                    return Text(str);
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.of(
                            context,
                          ).pushNamed("/storage/player", arguments: str),
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            decodedString,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })
                .toList(),
          ),
        ),
      ),
    );
  }
}
