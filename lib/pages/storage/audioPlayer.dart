import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:smart_health_monitor/components/FileParser.dart';
import 'package:smart_health_monitor/components/buttons.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';
import 'package:smart_health_monitor/main.dart';

class AudioPlayerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AudioPlayer();
  }
}

class _AudioPlayer extends State<AudioPlayerPage> {
  final player = AudioPlayer();
  var isPlaying = false;
  var isSeeking = false;
  var sliderPosition = 0.0;
  var filePath;

  var hasInitialized = false;

  void changePosition(double position) async {
    var duration = await player.getDuration();
    player.seek(
      Duration(
        milliseconds: (position * duration!.inMilliseconds).toInt(),
      ),
    );

    setState(() {
      sliderPosition = position;
    });
  }

  void initialize() async {
    filePath = ModalRoute.of(context)?.settings.arguments as String?;
    if (filePath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: const Text("No such file exists")));
      Navigator.of(context).pop();
    }

    player.positionUpdater = TimerPositionUpdater(
      interval: const Duration(milliseconds: 100),
      getPosition: player.getCurrentPosition,
    );
    await player.setReleaseMode(ReleaseMode.loop);
    await player.setSource(DeviceFileSource(filePath!));
    player.onPositionChanged.listen((Duration dur) async {
      if (player.state == PlayerState.paused) {
        return;
      }
      if (!mounted) {
        return;
      }
      var duration = await player.getDuration();
      var progress = dur.inMilliseconds.toDouble() / (duration!.inMilliseconds.toDouble() + 0.0001);
      setState(() {
        sliderPosition = progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasInitialized) {
      initialize();
      hasInitialized = true;
    }

    var localizations = AppLocalizations.of(context)!;

    var decodedString = FileParser.toDisplayString(
      FileParser.decode(filePath!),
      localizations,
    );
    var split = decodedString.split(" ");
    var date = split.removeAt(0).replaceAll(RegExp(r'[\(\)]'), "");
    var name = split.join(" ");

    var titleStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(title: Text(localizations.storage)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(date, style: titleStyle),
              Text(name, style: titleStyle),
              Slider(
                value: sliderPosition,
                onChanged: changePosition,
                onChangeStart: (val) => {player.pause()},
                onChangeEnd: (val) => {
                  if (isPlaying) {player.resume()},
                },
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlayerButton(
                      icon: "assets/player-play.png",
                      onPressed: () {isPlaying = true; player.resume();},
                    ),
                    SizedBox(width: 10),
                    PlayerButton(
                      icon: "assets/player-pause.png",
                      onPressed: () {isPlaying = false; player.pause();},
                    ),
                    SizedBox(width: 10),
                    PlayerButton(
                      icon: "assets/player-stop.png",
                      onPressed: () {isPlaying = false; player.stop();},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    super.dispose();
  }
}
