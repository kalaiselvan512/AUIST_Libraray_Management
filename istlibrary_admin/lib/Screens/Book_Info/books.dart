import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:istlibrary_admin/Screens/Book_Info/more_details.dart';
// import 'package:istlibrary/screens/Signup/signup.dart';
import 'package:localstorage/localstorage.dart';

class BookInfo extends StatefulWidget {
  const BookInfo({Key? key}) : super(key: key);

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  final LocalStorage storage = LocalStorage('lib_app');
  var JsonData;
  final url = 'http://127.0.0.1:8000/api/books/';
  booksapi() async {
    try {
      final response = await get(
        Uri.parse(url),
      );
      var statusCode = response.statusCode;
      JsonData = jsonDecode(response.body);
      // for (var i in JsonData) {
      //   print(i);
      // }

      setState(() {
        JsonData;
      });
      // print(statusCode);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    booksapi();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    JsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Information'),
      ),
      body: ListView(
        children: [
          if (JsonData == null)
            const Center(child: Text("No Books"))
          else if (JsonData != null)
            for (var i in JsonData.toList())
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Center(
                        child: Text("${i['bookid']}"),
                      ),
                    ),
                    SizedBox(
                      height: 130,
                      width: 100,
                      child: Card(
                        // color: Colors.grey[900],
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          // borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image(image: NetworkImage("${i['image']}")),
                        // margin: const EdgeInsets.all(20.0),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Center(
                        child: Text('${i['title']}'),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Center(
                        child: Text('${i['author1']}'),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Center(
                        child: Text('${i['domain']}'),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Center(
                        child: Text('${i['rack']}'),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    RichText(
                        text: TextSpan(
                            text: "More details",
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                storage.setItem("bookid", "${i['bookid']}");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MoreDetails()));
                              })),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}