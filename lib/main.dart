import 'package:flutter/material.dart';
import 'package:github_trending/card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import './reposdata.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<ReposData> reposData;

  List<ReposData> reposdetails = [];
  Future<List<ReposData>> reposDetails() async {
    var data = await http.get(
        "https://github-trending-api.now.sh/repositories?language=&since=daily");
    var jsonData = json.decode(data.body);

    for (var rval in jsonData) {
      ReposData books = ReposData(rval['author'], rval['name'], rval['avatar'],
          rval['url'], rval['description'], rval['stars'], rval['forks']);
      reposdetails.add(books);
    }
    return reposdetails;
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
        body: Center(
          child: FutureBuilder(
            future: reposDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RepoCard(snapshot);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}