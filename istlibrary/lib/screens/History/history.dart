import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'package:localstorage/localstorage.dart';

class History extends StatefulWidget {
  final double opacity;
  const History({Key? key, required this.opacity}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  final LocalStorage storage = LocalStorage('lib_app');
  var JsonData;
  final url = 'http://127.0.0.1:8000/api/history/';
  historyapi() async {
    try {
      final response = await post(Uri.parse(url),
          body: {"userid": storage.getItem('userid')});
      var statusCode = response.statusCode;
      JsonData = jsonDecode(response.body);

      setState(() {
        JsonData;
      });
      // print(statusCode);
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    super.initState();
    historyapi();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    JsonData;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.white.withOpacity(widget.opacity),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Bookid',
                        style: TextStyle(
                          color: Color(0xFF077bd7),
                          fontSize: 16,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 150),
                      InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Title',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                color: Color(0xFF077bd7),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      SizedBox(width: 280),
                      InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Borrowed Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                color: Color(0xFF077bd7),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      SizedBox(width: 210),
                      InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Status',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                color: Color(0xFF077bd7),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      SizedBox(width: 300),

                      InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Return Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                color: Color(0xFF077bd7),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: 50,
                      // ),
                      // SizedBox(
                      //   width: 250,
                      //   child: TextFormField(
                      //     controller: search,
                      //     onChanged: (value) {
                      //       // ignore: unnecessary_null_comparison
                      //       if (search == null) {
                      //         setState(
                      //           () => booksapi(),
                      //         );
                      //       }
                      //     },
                      //     cursorColor: Colors.black,
                      //     keyboardType: TextInputType.text,
                      //     decoration: const InputDecoration(
                      //       contentPadding: EdgeInsets.only(
                      //           left: 15, bottom: 11, top: 11, right: 15),
                      //       hintText: "Book_Title",
                      //       border: OutlineInputBorder(),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
                      width: 50,
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
                        child: Text('${i['date']}'),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Center(
                        child: Text('${i['status']}'),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                      width: 300,
                      child: Center(
                        child: Text(
                            '${DateFormat("yyyy-MM-dd").format(DateTime.parse(i['date']).add(Duration(days: 90)))}'),
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
