import 'package:flutter/material.dart';
import 'package:readlist/api/gist.dart';
import 'package:readlist/components/loading_screen.dart';
import 'package:readlist/models/read_list_item.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  GistAPI api = new GistAPI();

  Future<List<ReadListItem>> futureReadList;

  @override
  void initState() {
    super.initState();
    futureReadList = api.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read List'),
      ),
      body: FutureBuilder<List<ReadListItem>>(
        future: futureReadList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var readList = snapshot.data;

            if (readList.length <= 0) {
              return Center(
                child: Text("No Data!"),
              );
            }

            return ListView(
              children: readList
                  .map((readListItem) => ListTile(
                        title: Text(readListItem.title),
                      ))
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error when fetching data!"),
            );
          }

          return LoadingScreen();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/form'),
        tooltip: 'Add New List',
        child: Icon(Icons.add),
      ),
    );
  }
}
