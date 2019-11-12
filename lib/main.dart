import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ReposData {
  final String author;
  final String name;
  final String avatar;
  final String url;
  final String description;
  final int stars;
  final int forks;

  ReposData(this.author, this.name, this.avatar, this.url, this.description,
      this.stars, this.forks);
}

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
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Card(
                          child: ListTile(
                            leading: Image.network(snapshot.data[index].avatar),
                            title: Text(snapshot.data[index].name),
                            subtitle: Text(snapshot.data[index].description),
                            isThreeLine: true,
                            onTap: () => launch(snapshot.data[index].url),
                          ),
                        ),
                      ],
                    );
                  },
                );
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