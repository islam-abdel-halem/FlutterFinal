import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
  
void main() {

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: HomePage()
    );
  }
}


