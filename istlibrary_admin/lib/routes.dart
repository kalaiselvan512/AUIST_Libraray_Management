import "package:flutter/material.dart";
import 'package:fluro/fluro.dart';
import 'package:istlibrary_admin/Screens/Book_Info/books.dart';
import 'package:istlibrary_admin/Screens/Book_Info/create.dart';
import 'package:istlibrary_admin/Screens/Book_Info/domain.dart';
import 'package:istlibrary_admin/Screens/Book_Info/update.dart';
import 'package:istlibrary_admin/Screens/Home/home.dart';
import 'package:istlibrary_admin/Screens/Issue_Books/issue_books.dart';
import 'package:istlibrary_admin/Screens/Issue_Books/renewal_books.dart';
import 'package:istlibrary_admin/Screens/Login/login.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static final Handler _loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const LoginPage());

  static final Handler _homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const Homepage());

  static final Handler _bookinfoHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const BookInfo(
            opacity: 0.0,
          ));

  static final Handler _renewalHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const RenewalBooks(
            opacity: 0.0,
          ));

  static final Handler _issuebooksHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const IssueBooks(
            opacity: 0.0,
          ));

  static final Handler _createbooksHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const CreateBooks());

  static final Handler _updatebooksHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          const Update());

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
      '/home/bookinfo/update',
      handler: _updatebooksHandler,
    );
    router.define(
      '/home/renewalbooks',
      handler: _renewalHandler,
    );
    router.define(
      '/home/issuebooks',
      handler: _issuebooksHandler,
    );
    router.define(
      '/home/createbooks',
      handler: _createbooksHandler,
    );
  }
}
