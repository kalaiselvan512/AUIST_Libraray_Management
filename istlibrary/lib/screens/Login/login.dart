import 'dart:convert';
import 'dart:html';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:istlibrary/screens/Home/home.dart';
import 'package:istlibrary/screens/Signup/signup.dart';
import 'package:localstorage/localstorage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final url = 'http://127.0.0.1:8000/api/login/';
  // final Storage _localStorage = window.localStorage;
  final LocalStorage storage = LocalStorage('lib_app');

  TextEditingController userid = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    try {
      final response = await post(Uri.parse(url),
          body: {"userid": userid.text, "password": password.text});

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['success'] == true) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Homepage()));
          storage.setItem('userid', userid.text);
        } else {
          print(response.body);
        }
      } else {
        print("Server Error");
      }
    } catch (e) {
      print("error");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: const Text(
          'Faculty',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
          ),
        ),
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40), // if you need this
            side: BorderSide(
              color: Colors.grey.withOpacity(0.9),
              width: 1,
            ),
          ),
          child: SizedBox(
            // color: Colors.blue[200],
            width: 900,
            height: 500,
            child: Row(
              children: [
                Flexible(
                  child: Image.asset(
                    'assets/images/loginpageimage.png',
                    width: 400,
                    height: 500,
                  ),
                ),
                SizedBox(
                  height: 300,
                  width: 30,
                  child: VerticalDivider(
                    width: 1,
                    color: Colors.blueGrey[100],
                    thickness: 1,
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: userid,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "User Id",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: password,
                          cursorColor: Colors.black,
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Password",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: login,
                        child: const Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          textStyle: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: "New User?",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: "SignUp",
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUppage()));
                                    })
                            ]),
                          ),
                          const SizedBox(
                            width: 200,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Forget Password",
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const SignUppage()));
                                    })
                            ]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
