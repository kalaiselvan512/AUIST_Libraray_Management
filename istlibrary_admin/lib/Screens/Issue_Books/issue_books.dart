import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class IssueBooks extends StatefulWidget {
  final double opacity;
  const IssueBooks({Key? key, required this.opacity}) : super(key: key);

  @override
  State<IssueBooks> createState() => _IssueBooksState();
}

class _IssueBooksState extends State<IssueBooks> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  var JsonData;
  var Data;
  var bookid;
  var borrower;
  final url = 'http://127.0.0.1:8000/api/issuebooks/';
  final url2 = 'http://127.0.0.1:8000/api/returnbook/';
  final url3 = 'http://127.0.0.1:8000/api/mail/';
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

  returnbook() async {
    try {
      final response = await post(Uri.parse(url2),
          body: {"bookid": bookid, "userid": borrower});
      if (response.statusCode == 200) {
        Data = response.body;
      } else {
        print("Server Error");
      }
    } catch (e) {
      print(e);
    }
  }

  mail() async {
    try {
      final response = await post(Uri.parse(url3), body: {
        "borrower": borrower,
        "subject": subject.text,
        "message": message.text,
      });
      if (response.statusCode == 200) {
        Data = response.body;
      } else {
        print("Server Error");
      }
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

  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();

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
                      SizedBox(
                        width: 20,
                      ),
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
                      SizedBox(width: 180),
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
                      SizedBox(
                        width: 110,
                      ),
                      InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Borrower',
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
                      SizedBox(width: 145),
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
                      SizedBox(width: 130),

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
                      width: 20,
                    ),
                    SizedBox(
                      width: 80,
                      child: Center(
                        child: Text("${i['bookid']}"),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Center(
                        child: Text('${i['title']}'),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Center(
                        child: Text('${i['date']}'),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Center(
                        child: Text('${i['borrower']}'),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Center(
                        child: Text('${i['status']}'),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Center(
                        child: Text(
                            '${DateFormat("yyyy-MM-dd").format(DateTime.parse(i['date']).add(Duration(days: 90)))}'),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              bookid = i['bookid'];
                              borrower = i['borrower'];
                              returnbook();
                              setState(() {
                                booksapi();
                              });
                            },
                            child: Text("Return"))),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      child: Container(
                                        height: 500,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 600,
                                                // height: 200,
                                                child: TextField(
                                                  controller: subject,
                                                  cursorColor: Colors.black,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration:
                                                      const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15,
                                                            bottom: 11,
                                                            top: 11,
                                                            right: 15),
                                                    hintText: "Subject",
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              SizedBox(
                                                width: 600,
                                                // height: 300,
                                                child: TextField(
                                                  controller: message,
                                                  cursorColor: Colors.black,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration:
                                                      const InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15,
                                                            bottom: 40,
                                                            top: 40,
                                                            right: 15),
                                                    hintText: "Message",
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              SizedBox(
                                                width: 320.0,
                                                height: 50,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    borrower = i['borrower'];
                                                    mail();
                                                    Navigator.pop(
                                                        context, true);
                                                  },
                                                  child: Text(
                                                    "Send",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Color(0xFF1BC0C5),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Text("Mail"))),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
