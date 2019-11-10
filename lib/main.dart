import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var _index;
var _data;

class _MyAppState extends State<MyApp> {
  List _data;

  Future<String> getData() async {
    var response = await http.get(
        "https://github-trending-api.now.sh/repositories?language=&since=daily");

    this.setState(() {
      _data = json.decode(response.body);
    });
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Trending',
      home: Scaffold(
        appBar: AppBar(
          title: Text("GitHub Trending"),
          backgroundColor: Color(0xFFFF7C00),
        ),
        body: new ListView.builder(
            itemCount: _data == null ? 0 : _data.length,
            itemBuilder: (BuildContext context, _index) {
              return Column(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: Image.network(_data[_index]["avatar"]),
                      title: Text(_data[_index]["name"]),
                      subtitle: Text(_data[_index]["description"]),
                      isThreeLine: true,
                      onTap: () => launch(_data[_index]["url"])
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}