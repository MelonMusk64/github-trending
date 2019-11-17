import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import './reposdata.dart';

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