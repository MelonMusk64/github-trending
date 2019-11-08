import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response = await http.get(
      'https://github-trending-api.now.sh/repositories?language=&since=daily');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load');
  }
}

class Post {
  final String author;
  final String name;
  final String avatar;
  final String url;
  final String description;
  final String language;
  final String languagecolor;
  final int stars;
  final int forks;
  final int currentPeriodStars;

  Post(
      {this.author,
      this.name,
      this.avatar,
      this.url,
      this.description,
      this.language,
      this.languagecolor,
      this.stars,
      this.forks,
      this.currentPeriodStars});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        author: json['author'],
        name: json['name'],
        avatar: json['avatar'],
        url: json['url'],
        description: json['description'],
        language: json['language'],
        languagecolor: json['languagecolor'],
        stars: json['stars'],
        forks: json['forks'],
        currentPeriodStars: json['currentPeriodStars']);
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Post> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost();
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
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.author);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
