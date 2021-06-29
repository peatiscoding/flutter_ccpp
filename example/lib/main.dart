import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_ccpp/flutter_ccpp.dart';
import 'package:flutter_ccpp/pigeon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      FlutterCcpp.setup(CcppEnvironment.sandbox);
      platformVersion = 'Initialized';
      // Try make a new payment!
      var payment = await FlutterCcpp.makePanCreditCardPayment(
        "kSAops9Zwhos8hSTSeLTUa+y/Hc8FJ1w4/jAGUqhUcMU6mDXSirHZjqtn/wEgJi1w3nONLuU7kSTUYkknSfwRwNsxt7JB+kB+HYMCu5KbquzbbvRgzQEj455GM01dz8e",
        "4111111111111111",
        2,
        2022,
        "123",
        true
      );
      print(payment.responseCode);
      print(payment.redirectUrl);
      print(payment.error);
    } catch(e) {
      platformVersion = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
