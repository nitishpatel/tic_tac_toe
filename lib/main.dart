import 'package:flutter/material.dart';
import 'home.dart';
import 'splashscreen.dart';
void main(List<String> args) {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tic Tac Toe",
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFF273c75),
        accentColor: Color(0xFFc23616),
      ),
    );
  }
}