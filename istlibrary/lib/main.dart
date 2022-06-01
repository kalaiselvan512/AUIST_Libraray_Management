import 'package:flutter/material.dart';
import 'package:istlibrary/screens/Book_Info/books.dart';
import 'package:istlibrary/screens/Book_Info/more_details.dart';
import 'package:istlibrary/screens/Home/home.dart';
import 'package:istlibrary/screens/Login/login.dart';
import 'package:istlibrary/screens/Signup/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: {'/': (context) => Loginpage(), '/home': (context) => Homepage()},
      debugShowCheckedModeBanner: false,
      title: 'IST Library Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Loginpage(),
    );
  }
}
