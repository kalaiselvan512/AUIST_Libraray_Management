import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

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

  _domainrefresh() {
    if (domain == null) {
      return booksapi();
    } else {
      return domainapi();
    }
  }

  final LocalStorage storage = LocalStorage('lib_app');
  var JsonData;
  var Data;
  var bookid;
  var title;
  var status;

  final url = 'http://127.0.0.1:8000/api/books/';
  final url1 = 'http://127.0.0.1:8000/api/search/';
  final url2 = 'http://127.0.0.1:8000/api/borrowbook/';
  final url3 = 'http://127.0.0.1:8000/api/domainsearch/';
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

  domainapi() async {
    try {
      final response =
          await post(Uri.parse(url3), body: {"domain": domain.text});

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
      JsonData = json.decode(response.body);

      setState(() {
        JsonData;
        // print(JsonData);
      });
      // print(statusCode);
    } catch (e) {
      print(e);
    }
  }

  borrowbook() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    try {
      final response = await post(Uri.parse(url2), body: {
        "bookid": bookid,
        "title": title,
        "date": formattedDate,
        "borrower": storage.getItem("userid"),
        "status": status == 'Available' ? 'Not Available' : 'Available',
      });
      if (response.statusCode == 200) {
        Data = jsonDecode(response.body);
        print(Data);
      } else {
        print("Server Error");
      }
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    search.addListener(_refresh);
    domain.addListener(_domainrefresh);
    booksapi();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    JsonData;
  }

  TextEditingController search = TextEditingController();
  TextEditingController domain = TextEditingController();

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
                        width: 25,
                      ),
                      SizedBox(
                        width: 150,
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
                            hintText: "Title_Search",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          controller: domain,
                          onChanged: (value) {
                            // ignore: unnecessary_null_comparison
                            if (domain == null) {
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
                            hintText: "Domain_Search",
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
                    // SizedBox(
                    //   width: 120,
                    //   height: 50,
                    //   child: ElevatedButton(
                    //       onPressed: () {}, child: Text('Add to Cart')),
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => const BookInfo(
                            //           opacity: 0.0,
                            //         )));

                            // Navigator.pushNamed(context, 'home/');
                            bookid = i['bookid'];
                            title = i['title'];
                            status = i['status'];
                            borrowbook();

                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Message'),
                                content: Text(Data['success'] == true
                                    ? "${Data['description']}"
                                    : "${Data['err']}"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );

                            setState(() {
                              i['status'] = "Not Available";
                            });
                          },
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //       content: Text(Data['err'] != null
                          //           ? "${Data['err']}"
                          //           : "${Data['description']}")));
                          // },
                          child: Text('Borrow')),
                    )
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
