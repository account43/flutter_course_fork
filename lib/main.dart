import 'dart:math';

import 'package:flutter/material.dart';

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
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<int> ballNumber = List.generate(5, (index) => index + 1);
  List<String> ballAssets = [];
  final Random rand = Random();
  String ball = "assets/ball1.png";

  @override
  void initState() {
    createBallAssets();
    super.initState();
  }

  void createBallAssets() {
    for (var ball in ballNumber) {
      ballAssets.add("\assets/ball$ball.png");
    }
  }

  void randNum() {
    int rand1 = rand.nextInt(5);

    setState(() {
      ball = ballAssets[rand1];
    });
    print(ball);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Ask Me Anything...",
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ball,
                  width: 260,
                  height: 260,
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  foregroundColor: Colors.blue[600],
                  textStyle: TextStyle(fontSize: 33)),
              onPressed: () => randNum(),
              child: Text("Button"),
            )
          ],
        ),
      ),
    );
  }
}
