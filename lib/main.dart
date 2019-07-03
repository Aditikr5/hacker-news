import 'package:flutter/material.dart';
import 'package:scopemodelproject/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HackNews App",
      initialRoute: '/',
      routes: routes,
    );
  }
}