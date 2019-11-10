import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String> getData() async {
    var response = await http.get(
        "https://github-trending-api.now.sh/repositories?language=&since=daily"
    );

    List data = json.decode(response.body);
    print(data/*[0]["name"]*/);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Trending',
      home: Scaffold(
        appBar: AppBar(
          title: Text("GitHub Trending"),
        ),
        body: Center(
          child: RaisedButton(
            child: Text("Get data"),
            onPressed: getData,
          ),
        ),
      ),
    );
  }
}
