import 'package:flutter/material.dart';
import 'package:readlist/api/gist.dart';
import 'package:readlist/components/read_list_tile.dart';
import 'package:readlist/components/sort_filter_dialog.dart';
import 'package:readlist/models/read_list_item.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<ReadListItem>> _futureReadList;

  @override
  void initState() {
    super.initState();
    _futureReadList = GistAPI.fetchData();
  }

  void _openView(String route) async {
    await Navigator.pushNamed(context, route);
    setState(() {
      _futureReadList = GistAPI.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => SortFilterDialog(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _openView('/setting'),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => setState(() {
              _futureReadList = GistAPI.fetchData();
            }),
          ),
        ],
      ),
      body: FutureBuilder<List<ReadListItem>>(
        future: _futureReadList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var readList = snapshot.data;

            if (readList.length <= 0) {
              return Center(child: Text("No Data!"));
            }

            readList.sort((x, y) => y.updatedAt.compareTo(x.updatedAt));

            return ListView(
              children: readList
                  .map((readListItem) => ReadListTile(readListItem))
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Error when fetching data!"),
                  Text("Make sure you already set up you setting."),
                  ElevatedButton(
                    onPressed: () => _openView('/setting'),
                    child: Text('Open Setting'),
                  ),
                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openView('/form'),
        tooltip: 'Add New List',
        child: Icon(Icons.add),
      ),
    );
  }
}
