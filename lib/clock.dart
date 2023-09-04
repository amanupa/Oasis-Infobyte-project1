import 'package:flutter/material.dart';
import 'dart:async';
import 'package:stopwatch/clock_painter.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  final Stopwatch stopwatch = Stopwatch(); //_stopwatch

  late Timer _timer;
  bool isRunning = false;
  int milliseconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

//to start the watch
  void _startTimer() {
    if (!stopwatch.isRunning) {
      stopwatch.start();
      isRunning = true;
      updateStopwatch();
    }
  }

//to update
  void updateStopwatch() {
    if (stopwatch.isRunning) {
      Future.delayed(const Duration(milliseconds: 1), () {
        if (stopwatch.isRunning) {
          setState(() {
            milliseconds = stopwatch.elapsedMilliseconds;
            updateStopwatch();
          });
        }
      });
    }
  }

//to reset the watch
  void resetStopwatch() {
    if (!stopwatch.isRunning) {
      stopwatch.reset();
      milliseconds = 0;
    }
  }

//to stop the watch
  void stopStopwatch() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      isRunning = false;
    }
  }

  String formMilisecond(int milliseconds) {
    int minutes = (milliseconds / 60000).floor();
    int seconds = ((milliseconds % 60000) / 1000).floor();
    int hundredths = (milliseconds % 1000) ~/ 10;

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredthsStr = hundredths.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr.$hundredthsStr';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 136, 242, 246),
          Color.fromARGB(255, 200, 160, 238)
        ], tileMode: TileMode.mirror),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellowAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.7),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(1, 5),
                  ),
                ],
              ),
              child: CustomPaint(
                painter: ClockVisual(),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              formMilisecond(milliseconds),
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      if (isRunning) {
                        stopStopwatch();
                      } else {
                        _startTimer();
                      }
                    });
                  }, //_toggleStopwatch,
                  child: Text(isRunning
                      ? 'Stop'
                      : 'Start'), //changing the text and function of elevated button by conditioning
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.5)),
                  onPressed: () {
                    setState(() {
                      resetStopwatch();
                    });
                    /* _stopwatch.reset();
                        setState(() {});*/
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
