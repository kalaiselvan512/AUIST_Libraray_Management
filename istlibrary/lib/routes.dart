import "package:flutter/material.dart";
import 'package:fluro/fluro.dart';
import 'package:istlibrary/screens/Book_Info/books.dart';
import 'package:istlibrary/screens/History/history.dart';
import 'package:istlibrary/screens/Home/domain.dart';
import 'package:istlibrary/screens/Home/home.dart';
import 'package:istlibrary/screens/Lend_Books/lend.dart';
import 'package:istlibrary/screens/Login/login.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static final Handler _loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const Loginpage());

  static final Handler _homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const Homepage());

  static final Handler _bookinfoHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const BookInfo(
            opacity: 0.0,
          ));

  static final Handler _historyHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const History(
            opacity: 0.0,
          ));

  static final Handler _borrowbooksHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const LendedBooks(
            opacity: 0.0,
          ));

  static final Handler _domainHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const Domainpage(
            opacity: 0.0,
          ));

  static void setupRouter() {
    router.define(
      '/',
      handler: _loginHandler,
    );
    router.define(
      '/home/',
      handler: _homeHandler,
    );
    router.define(
      '/home/domain',
      handler: _domainHandler,
    );
    router.define(
      '/home/bookinfo',
      handler: _bookinfoHandler,
    );
    router.define(
      '/home/history',
      handler: _historyHandler,
    );
    router.define(
      '/home/borrowbooks',
      handler: _borrowbooksHandler,
    );
  }
}
