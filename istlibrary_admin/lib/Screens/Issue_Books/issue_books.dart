import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class IssueBooks extends StatefulWidget {
  const IssueBooks({Key? key}) : super(key: key);

  @override
  State<IssueBooks> createState() => _IssueBooksState();
}

class _IssueBooksState extends State<IssueBooks> {
  var JsonData;
  final url = 'http://127.0.0.1:8000/api/issuebooks/';
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
        title: const Text('Issue Books'),
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
                        child: Text('${i['borrower']}'),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Center(
                        child: Text('${i['status']}'),
                      ),
                    ),
                    // SizedBox(
                    //   width: 200,
                    //   child: Center(
                    //     child: Text('${i['rack']}'),
                    //   ),
                    // ),
                    const SizedBox(
                      width: 50,
                    ),
                    // RichText(
                    //     text: TextSpan(
                    //         text: "More details",
                    //         style: const TextStyle(
                    //             color: Colors.blue,
                    //             fontWeight: FontWeight.bold,
                    //             decoration: TextDecoration.underline),
                    //         recognizer: TapGestureRecognizer()
                    //           ..onTap = () {
                    //             storage.setItem("bookid", "${i['bookid']}");
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         const MoreDetails()));
                    //           })),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
