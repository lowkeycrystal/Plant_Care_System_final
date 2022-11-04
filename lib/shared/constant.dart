import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  border: OutlineInputBorder(),
  labelStyle: TextStyle(
      color: Color.fromARGB(150, 18, 64, 38),
      fontSize: 17,
      fontFamily: 'AvenirLight'),
  fillColor: Colors.white,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 18, 64, 38), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 18, 64, 38), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  hintStyle: TextStyle(
      color: Color.fromARGB(150, 18, 64, 38),
      fontSize: 11,
      fontFamily: 'AvenirLight'),
);
