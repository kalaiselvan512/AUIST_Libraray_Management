import 'package:flutter/material.dart';
import 'package:istlibrary_admin/Screens/Book_Info/books.dart';
import 'package:istlibrary_admin/Screens/Book_Info/create.dart';
import 'package:istlibrary_admin/Screens/Book_Info/update.dart';
import 'package:istlibrary_admin/Screens/Home/home.dart';
import 'package:istlibrary_admin/Screens/Login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IST Library Adimn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
