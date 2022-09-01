import 'package:bytebank_persistence/database/app_database.dart';
import 'package:bytebank_persistence/models/contact.dart';
import 'package:flutter/material.dart';

import 'screens/dashboard.dart';

void main() {
  runApp(const BytebankApp());
  save(Contact(0, 'Alexandre', 1000));
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[900],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.lightBlue[700],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[900],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.blueAccent[700],
            ),
          ),
        ),
      ),
      home: const Dashboard(),
    );
  }
}
