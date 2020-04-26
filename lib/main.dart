import 'package:flutter/material.dart';
import 'package:the_attendence_manager_app/ui/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendence Manager',
      home: new Home(),

    );
  }
}
