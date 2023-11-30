import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/models/egg_model.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late String titleText;
  Map jajaCzas = {
    "hard": 7.0,
    "medium": 4.0,
    "soft": 3.0,
  };

  Map jajaTitle = {
    "hard": "twarto",
    "medium": "mieko",
    "soft": "wolno",
  };

  final EggModel soft = EggModel(hardnessTitle: "na miekko", time: 3.0);
  final EggModel medium = EggModel(hardnessTitle: "na srenio", time: 4.0);
  final EggModel hard = EggModel(hardnessTitle: "na twardo", time: 7.0);

  double progressBar = 0.0;
  double secondPass = 0.0;
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    titleText = "Rodzja jaki JaJkA?";
    super.initState();
  }

  void selectEgg(EggSelection select) {
    secondPass = 0.0;
    progressBar = 0.0;
    switch (select) {
      case EggSelection.soft:
        jajoAction(soft);
      case EggSelection.medium:
        jajoAction(medium);
      case EggSelection.hard:
        jajoAction(hard);
    }
  }

  void jajoAction(EggModel eggModel) {
    setState(() {
      titleText = eggModel.hardnessTitle;
    });
    var startTime = eggModel.time;
    Timer.periodic(Duration(seconds: 1), (timer) {
      secondPass++;
      setState(() {
        progressBar = secondPass / startTime;
      });

      if (secondPass >= eggModel.time) {
        timer.cancel();
        setState(() {
          titleText = "ugutowane";
        });
        player.play(
          AssetSource("alarm_sound.mp3"),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            titleText,
            style: GoogleFonts.nabla(
              fontSize: 40,
              backgroundColor: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Jajo("assets/soft_egg@3x.png",
                    () => selectEgg(EggSelection.soft)),
                Jajo("assets/medium_egg@3x.png",
                    () => selectEgg(EggSelection.medium)),
                Jajo("assets/hard_egg@3x.png",
                    () => selectEgg(EggSelection.hard)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 30,
            ),
            child: LinearProgressIndicator(
              value: progressBar,
            ),
          )
        ],
      ),
    ));
  }
}

class Jajo extends StatelessWidget {
  const Jajo(
    this.asset,
    this.onTap, {
    Key? key,
  }) : super(key: key);

  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Image.asset(
            asset,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
