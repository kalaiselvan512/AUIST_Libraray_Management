import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreateBooks extends StatefulWidget {
  const CreateBooks({Key? key}) : super(key: key);

  @override
  State<CreateBooks> createState() => _CreateBooksState();
}

class _CreateBooksState extends State<CreateBooks> {
  var Data;
  final url = 'http://127.0.0.1:8000/api/createbooks/';

  postdata() async {
    try {
      final response = await post(Uri.parse(url), body: {
        "bookid": bookid.text,
        "title": title.text,
        "secondary_title": secondary_title.text,
        "edition": edition.text,
        "author1": author1.text,
        "author2": author2.text,
        "author3": author3.text,
        "domain": domain.text,
        "status": status.text,
        "rack": rack.text,
        "image": image.text,
      });
      // print(response);
      if (response.statusCode == 200) {
        Data = response.body;
      } else {
        print("Server Error");
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController bookid = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController secondary_title = TextEditingController();
  TextEditingController edition = TextEditingController();
  TextEditingController author1 = TextEditingController();
  TextEditingController author2 = TextEditingController();
  TextEditingController author3 = TextEditingController();
  TextEditingController domain = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController rack = TextEditingController();
  TextEditingController image = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Books'),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: bookid,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Book ID",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: secondary_title,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Secondary Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: image,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Image",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              const SizedBox(
                width: 400,
              ),
              ElevatedButton(
                  onPressed: () {
                    postdata();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(Data['err'] != null
                            ? "${Data['err']}"
                            : "${Data['description']}")));
                  },
                  child: const Text('Create'))
            ],
          ),
        ),
      ),
    );
  }
}
