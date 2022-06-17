import 'package:flutter/material.dart';
import 'package:istlibrary_admin/Screens/Book_Info/create.dart';
import 'package:istlibrary_admin/Screens/Issue_Books/renewal_books.dart';
import 'package:istlibrary_admin/Screens/Issue_Books/issue_books.dart';
import 'package:istlibrary_admin/Screens/Login/login.dart';
import 'package:istlibrary_admin/screens/Book_Info/books.dart';
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // String usr = storage.getItem('userid');

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
                    width: screenSize.width / 6,
                  ),
                  const Text(
                    ('Librarian'),
                    style: TextStyle(
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
                      Navigator.pushNamed(context, '/home/renewalbooks');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Renew Books',
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
                      Navigator.pushNamed(context, '/home/issuebooks');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Issue Books',
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
                      Navigator.pushNamed(context, '/home/createbooks');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Create Books',
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
                  SizedBox(width: screenSize.width / 15),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[4] = true : _isHovering[4] = false;
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
                              color: _isHovering[4]
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
                          visible: _isHovering[4],
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
