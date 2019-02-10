import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import './pl/HomePage/HomePage.dart';

void main() async {
  bool succeded = await Utils.Initialize();
  if (succeded) {
    runApp(MyApp());
  } else {
    runApp(ErrorPage());
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text(Utils.getText(18)),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
          primaryColor: Colors.amber[50],
          accentColor: Colors.brown,
          fontFamily: "Usmani"),
    );
  }
}
