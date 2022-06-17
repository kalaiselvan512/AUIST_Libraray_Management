import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:istlibrary_admin/Screens/Book_Info/update.dart';

import 'package:localstorage/localstorage.dart';

class BookInfo extends StatefulWidget {
  final double opacity;
  const BookInfo({Key? key, required this.opacity}) : super(key: key);

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  _refresh() {
    if (search == null) {
      return booksapi();
    } else {
      return searchapi();
    }
  }

  final LocalStorage storage = LocalStorage('lib_app');
  var JsonData;
  var Data;

  final url = 'http://127.0.0.1:8000/api/books/';
  final url1 = 'http://127.0.0.1:8000/api/search/';
  final url2 = 'http://127.0.0.1:8000/api/deletebook/';
  deletebook() async {
    try {
      final response = await post(Uri.parse(url2),
          body: {"bookid": storage.getItem('bookid')});
      if (response.statusCode == 200) {
        Data = response.body;
      } else {
        print("Server Error");
      }
    } catch (e) {
      print(e);
    }
  }

  searchapi() async {
    try {
      final response =
          await post(Uri.parse(url1), body: {"title": search.text});

      var statusCode = response.statusCode;
      JsonData = jsonDecode(response.body);
      // for (var i in JsonData) {
      //   print(i);
      // }

      setState(() {
        JsonData;
        // print(JsonData);
      });
      // print(statusCode);
    } catch (e) {
      print(e);
    }
  }

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
        // print(JsonData);
      });
      // print(statusCode);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    search.addListener(_refresh);
    booksapi();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    JsonData;
  }

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    var _text = '';
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
                      SizedBox(width: 250),
                      InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Author',
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
                      SizedBox(width: 250),
                      InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Domain',
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
                              'Rack',
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
                      SizedBox(width: 85),
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
                      SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: search,
                          onChanged: (value) {
                            // ignore: unnecessary_null_comparison
                            if (search == null) {
                              setState(
                                () => booksapi(),
                              );
                            }
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Book_Title",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
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
                height: 100,
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
                        child: Text('${i['bookid']}'),
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
                      width: 50,
                      child: Center(
                        child: Text('${i['rack']}'),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Center(
                        child: Text('${i['status']}'),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            storage.setItem('bookid', i['bookid']);
                            deletebook();
                            setState(() {
                              booksapi();
                            });
                          },
                          child: Text('Delete')),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            storage.setItem('bookid', i['bookid']);
                            Navigator.pushNamed(
                                context, '/home/bookinfo/update');
                          },
                          child: Text('Update')),
                    )
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
