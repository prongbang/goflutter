import 'package:flutter/material.dart';
import 'package:goflutter/example.gen.dart';

import 'package:goflutter/goflutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _bridge = Bridge.open();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(_bridge.add(1, 2).toString()),
        ),
      ),
    );
  }
}
