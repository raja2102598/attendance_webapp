import 'package:flutter/material.dart';

import 'AttendanceDetailsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'attendance'),
      routes: {
        AttendanceDetailsScreen.routeName: (context) =>
            AttendanceDetailsScreen(),
      },
      supportedLocales: [
        const Locale('en', 'US'), // English
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AttendanceDetailsScreen.routeName);
        },
        child: Text('Attendance Records'),
      )),
    );
  }
}
