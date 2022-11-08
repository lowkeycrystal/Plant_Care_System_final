import 'dart:html';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'How it works',
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 18, 64, 38),
        )),
        home: Scaffold(
            appBar: AppBar(
              iconTheme:
                  IconThemeData(color: Color.fromARGB(255, 199, 217, 137)),
              centerTitle: true,
              title: const Text(
                'How it works',
                style: TextStyle(color: Color.fromARGB(255, 199, 217, 137)),
              ),
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
              ),
            ),
            backgroundColor: Color.fromARGB(255, 199, 217, 137),
            body: Center()));
  }
}
