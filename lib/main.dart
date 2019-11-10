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
  List data;

  Future<String> getData() async {
    var response = await http.get(
        "https://github-trending-api.now.sh/repositories?language=&since=daily");

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[0]["name"]);
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
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        data[index]["name"],
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 1.8),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        data[index]["description"],
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
