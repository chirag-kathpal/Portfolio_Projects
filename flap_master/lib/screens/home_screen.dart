import 'dart:async';

import 'package:flap_master/widgets/barriers.dart';
import 'package:flap_master/widgets/bird.dart';
import 'package:flutter/material.dart';

import '../widgets/score_board.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  static bool gameHasStarted = false;
  static double barrierXone = 1.5;
  double barrierXtwo = barrierXone + 1.5;
  int score = 0;
  int bestScore = 0;
  @override
  void initState() {
    gameHasStarted = false;
    birdYaxis = 0;
    time = 0;
    initialHeight = birdYaxis;
    barrierXone = 1.8;
    barrierXtwo = barrierXone + 1.8;
    score = 0;
    super.initState();
  }

  void onInit() {
    setState(() {
      gameHasStarted = false;
      birdYaxis = 0;
      time = 0;
      initialHeight = birdYaxis;
      barrierXone = 1.8;
      barrierXtwo = barrierXone + 1.8;
      score = 0;
    });
  }

  bool checkBarrierCollision() {
    if (barrierXone > -0.3 && barrierXone < 0.8) {
      if (birdYaxis < -0.5 || birdYaxis > 0.5) {
        return true;
      }
    }
    if (barrierXtwo > -0.3 && barrierXtwo < 0.8) {
      if (birdYaxis < -0.7 || birdYaxis > 0.6) {
        return true;
      }
    }
    return false;
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        birdYaxis = initialHeight - height;
        if (barrierXone < -0.75 && barrierXone > -0.79) {
          score += 1;
        }
        if (barrierXtwo < -0.74 && barrierXtwo > -0.78) {
          score += 1;
        }
      });

      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      if (birdYaxis > 1 || checkBarrierCollision()) {
        timer.cancel();
        _showDialog();
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Text(
              'Game Over',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Score: $score",
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  if (birdYaxis > 1 || gameHasStarted == true) {
                    if (score > bestScore) {
                      bestScore = score;
                    }
                  }

                  onInit();
                  setState(() {
                    gameHasStarted = false;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "PLAY AGAIN",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: const MyBird(),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.25),
                    child: gameHasStarted
                        ? const Text('')
                        : const Text(
                            'T A P  T O  P L A Y',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(
                      size: 170.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(
                      size: 190.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(
                      size: 130.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: const Barriers(
                      size: 230.0,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            ScoreBoard(
              score: score,
              bestScore: bestScore,
            ),
          ],
        ),
      ),
    );
  }
}
