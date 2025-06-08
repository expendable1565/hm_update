import 'package:flutter/material.dart';
import 'package:smart_health_monitor/components/recorder.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class DiagnoseLung extends StatefulWidget {
  const DiagnoseLung({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DiagnoseLung();
  }
}

class _DiagnoseLung extends State<DiagnoseLung> {
  int placement = -2;
  bool isRecording = false;

  final _imageKey = GlobalKey();
  final IMAGE_ORIG_SIZE = Size(379.4, 421.5);

  var placements = {
    "FrontLungs": [
      Offset(128, 105),
      Offset(246, 105),
      Offset(243, 168),
      Offset(161, 168),
      Offset(91, 278),
      Offset(300, 278),
      Offset(350, 160),
      Offset(41, 168),
    ],
    "BackLungs": [
      Offset(150, 118),
      Offset(222, 120),
      Offset(220, 165),
      Offset(150, 165),
      Offset(150, 210),
      Offset(220, 210),
      Offset(280, 275),
      Offset(95, 275),
    ],
  };

  int getPlacement(Offset offset, String which) {
    var currentPlacements = placements[which]!;
    int result = -1;

    var box = _imageKey.currentContext!.findRenderObject() as RenderBox;
    var currentSize = box.size;
    var multiplier = currentSize.height / IMAGE_ORIG_SIZE.height;
    
    print([multiplier, offset]);

    for (var i = 0; i < currentPlacements.length; i++) {
      var targetoffset = currentPlacements[i];
      var xDiff = (targetoffset.dx * multiplier - offset.dx).abs();
      var yDiff = (targetoffset.dy * multiplier - offset.dy).abs();
      print([targetoffset, offset, i]);
      if (xDiff < 30 && yDiff < 30) {
        result = i;
        break;
      }
    }
    return result;
  }

  void _setIsRecording(bool recording) {
    isRecording = recording;
  }

  @override
  Widget build(BuildContext context) {
    String title = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.diagnose)),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.tapPlacement,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
              SizedBox(height: 1),
              Stack(
                children: [
                  GestureDetector(
                    onTapDown: (details) {
                      if (isRecording) {
                        return;
                      }
                      var newPlacement = getPlacement(
                        details.localPosition,
                        title,
                      );
                      setState(() {
                        placement = newPlacement + 1;
                      });
                    },
                    child: Image(image: AssetImage("assets/$title.jpg")),
                    key: _imageKey,
                  ),
                ],
              ),
              if (placement > 0)
                Recorder(title: "${AppLocalizations.of(context)!.recordPlacement} ${placement}", callback: _setIsRecording, name: "$title $placement"),
            ],
          ),
        ),
      ),
    );
  }
}
