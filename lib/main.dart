import 'package:flutter/material.dart';
import 'package:stopwatch/clock.dart';

void main() {
  runApp(
    const Myapp(),
  );
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 200, 160, 238),
          title: const Text('Stopwatch '),
        ),
        body: const Clock(),
      ),
    );
  }
}
