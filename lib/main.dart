import 'package:flutter/material.dart';
import 'package:github_trending/card.dart';

import './card.dart';
import './reposlist.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
