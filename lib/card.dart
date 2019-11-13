import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoCard extends StatelessWidget {
  final snapshot;

  RepoCard(this.snapshot);

  Widget build(BuildContext context) {
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
  }
}
