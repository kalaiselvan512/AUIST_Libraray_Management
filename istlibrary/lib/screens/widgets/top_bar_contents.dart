import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:istlibrary/screens/Book_Info/books.dart';
import 'package:istlibrary/screens/History/history.dart';
import 'package:istlibrary/screens/Lend_Books/lend.dart';
import 'package:istlibrary/screens/Login/login.dart';
import 'package:localstorage/localstorage.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  // ignore: prefer_const_constructors_in_immutables
  TopBarContents(this.opacity, {Key? key}) : super(key: key);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final LocalStorage storage = LocalStorage('lib_app');
  var JsonData;
  final url = 'http://127.0.0.1:8000/api/user/';

  userapi() async {
    try {
      final response = await post(Uri.parse(url),
          body: {"userid": storage.getItem("userid")});

      var statusCode = response.statusCode;
      JsonData = jsonDecode(response.body);
      // print(JsonData);

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

    userapi();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    JsonData;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
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
                    width: screenSize.width / 4,
                  ),
                  Text(
                    "${JsonData["username"]}",
                    style: const TextStyle(
                      color: Color(0xFF077bd7),
                      fontSize: 26,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(width: screenSize.width / 15),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[0] = true : _isHovering[0] = false;
                      });
                    },
                    onTap: () {
                      Navigator.pushNamed(context, '/home/bookinfo');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Book Information',
                          style: TextStyle(
                              color: _isHovering[0]
                                  ? const Color(0xFF077bd7)
                                  : const Color(0xFF077bd7),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[0],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: screenSize.width / 15),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[1] = true : _isHovering[1] = false;
                      });
                    },
                    onTap: () {
                      Navigator.pushNamed(context, '/home/borrowbooks');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Borrowed books',
                          style: TextStyle(
                              color: _isHovering[1]
                                  ? const Color(0xFF077bd7)
                                  : const Color(0xFF077bd7),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[1],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: screenSize.width / 15),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[2] = true : _isHovering[2] = false;
                      });
                    },
                    onTap: () {
                      Navigator.pushNamed(context, '/home/history');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'History',
                          style: TextStyle(
                              color: _isHovering[2]
                                  ? const Color(0xFF077bd7)
                                  : const Color(0xFF077bd7),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[2],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: screenSize.width / 15),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[3] = true : _isHovering[3] = false;
                      });
                    },
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                              color: _isHovering[3]
                                  ? const Color(0xFF077bd7)
                                  : const Color(0xFF077bd7),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[3],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
