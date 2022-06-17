import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:istlibrary_admin/Screens/Book_Info/update.dart';
import 'package:localstorage/localstorage.dart';

class Domainpage extends StatefulWidget {
  final double opacity;
  const Domainpage({Key? key, required this.opacity}) : super(key: key);

  @override
  State<Domainpage> createState() => _DomainpageState();
}

class _DomainpageState extends State<Domainpage> {
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
      return domainapi();
    } else {
      return searchapi();
    }
  }

  final LocalStorage storage = LocalStorage('lib_app');
  var JsonData;
  var Data;
  var bookid;
  var title;
  var status;
  final url = 'http://127.0.0.1:8000/api/domainbooks/';
  final url1 = 'http://127.0.0.1:8000/api/domainbooksearch/';
  final url2 = 'http://127.0.0.1:8000/api/borrowbook/';
  final url3 = 'http://127.0.0.1:8000/api/deletebook/';
  deletebook() async {
    try {
      final response = await post(Uri.parse(url3),
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
      final response = await post(Uri.parse(url1),
          body: {"domain": storage.getItem("domain"), "title": search.text});

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
      final response = await post(Uri.parse(url),
          body: {"domain": storage.getItem("domain")});

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
    domainapi();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    // domainapi();
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
                                () => domainapi(),
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
                      // SizedBox(
                      //   child: IconButton(
                      //     onPressed: () {
                      //       searchapi();
                      //     },
                      //     icon: const Icon(Icons.search),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Update()));
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
