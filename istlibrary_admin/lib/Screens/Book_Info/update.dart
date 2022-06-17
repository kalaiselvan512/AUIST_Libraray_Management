import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:istlibrary_admin/Screens/Book_Info/books.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final LocalStorage storage = LocalStorage('lib_app');

  var JsonData;
  var Data;

  final url = 'http://127.0.0.1:8000/api/book/';
  final url1 = 'http://127.0.0.1:8000/api/updatebooks/';
  bookapi() async {
    try {
      final response = await post(Uri.parse(url),
          body: {"bookid": storage.getItem('bookid')});
      var statusCode = response.statusCode;
      JsonData = jsonDecode(response.body);
      // print(JsonData);
      setState(() {
        JsonData;
      });
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
    // _title;
  }

  postdata() async {
    try {
      final response = await post(Uri.parse(url1), body: {
        "bookid": storage.getItem('bookid'),
        "title": title.text,
        "edition": edition.text,
        "author1": author1.text,
        "author2": author2.text,
        "author3": author3.text,
        "domain": domain.text,
        "publisher": publisher.text,
        "status": status.text,
        "rack": rack.text,
      });
      // print(response);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['success'] == true) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BookInfo(
                    opacity: 0.0,
                  )));
        }
      } else {
        print("Server Error");
      }
    } catch (e) {
      print(e);
    }
  }

  late TextEditingController title =
      TextEditingController(text: JsonData['title']);
  late TextEditingController edition =
      TextEditingController(text: JsonData['edition']);
  late TextEditingController author1 =
      TextEditingController(text: JsonData['author1']);
  late TextEditingController author2 =
      TextEditingController(text: JsonData['author2']);
  late TextEditingController author3 =
      TextEditingController(text: JsonData['author3']);
  late TextEditingController domain =
      TextEditingController(text: JsonData['domain']);
  late TextEditingController status =
      TextEditingController(text: JsonData['status']);
  late TextEditingController rack =
      TextEditingController(text: JsonData['rack']);
  late TextEditingController publisher =
      TextEditingController(text: JsonData['publisher']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: Center(
        // width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            const SizedBox(
              width: 400,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('Title'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: title,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Title",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Edition'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: edition,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Edition",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Author 1'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: author1,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Author 1",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Author 2'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: author2,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Author 2",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Author 3'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: author3,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Author 3",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Domain'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: domain,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Domain",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Status'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: status,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Status",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Rack'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: rack,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Rack",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('Publisher'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: publisher,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Publisher",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              width: 400,
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  postdata();
                },
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
