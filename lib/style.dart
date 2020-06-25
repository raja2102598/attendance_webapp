import 'package:flutter/material.dart';

abstract class Style {
  static const TextStyle style = TextStyle(
    fontSize: 22.0,
    fontFamily: 'CM Sans Serif',
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static const TextStyle substyle = TextStyle(
    color: Colors.white70,
    fontStyle: FontStyle.italic,
    fontSize: 18.0,
    fontFamily: 'CM Sans Serif',
  );

  static const TextStyle headStyle = TextStyle(
    fontSize: 17.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

//subheading styles

  static const TextStyle cellStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle columnStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle detailsHeadStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.black,
  );
}
