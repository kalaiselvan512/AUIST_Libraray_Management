import 'dart:convert';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';

class MoreDetails extends StatefulWidget {
  const MoreDetails({Key? key}) : super(key: key);

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  final LocalStorage storage = LocalStorage('lib_app');

  var JsonData;
  final url = 'http://127.0.0.1:8000/api/book/';
  final url1 = 'http://127.0.0.1:8000/api/borrowbook/';
  bookapi() async {
    try {
      final response = await post(Uri.parse(url),
          body: {"bookid": storage.getItem('bookid')});
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

  var Data;
  borrowbook() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    try {
      final response = await post(Uri.parse(url1), body: {
        "bookid": storage.getItem('bookid'),
        "title": JsonData['title'],
        "date": formattedDate,
        "borrower": storage.getItem("userid"),
        "status": JsonData['status'] == 'Available' ? 'On loan' : 'Available',
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
    bookapi();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    JsonData;
  }

  @override
  Widget build(BuildContext context) {
    var bookid = storage.getItem('bookid');
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Details'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
          ),
        ),
        child: Row(children: [
          Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(JsonData['image'].toString()),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text("${JsonData['bookid']}")),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text("${JsonData['title']}")),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child:
                        Center(child: Text("${JsonData['secondary_title']}")),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text("${JsonData['edition']}")),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text("${JsonData['author1']}")),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text("${JsonData['author2']}")),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text("${JsonData['author3']}")),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text("${JsonData['domain']}")),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text("${JsonData['rack']}")),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 200,
                    child: Center(child: Text("${JsonData['status']}")),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                borrowbook();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(Data['err'] != null
                        ? "${Data['err']}"
                        : "${Data['description']}")));
              },
              child: Text('Lend'),
            ),
          ),
          const SizedBox(
            width: 100,
          )
        ]),
      ),
    );
  }
}
