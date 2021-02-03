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

  Future<List<ReadListItem>> _futureReadList;

  @override
  void initState() {
    super.initState();
    _futureReadList = api.fetchData();
  }

  void _openForm() async {
    await Navigator.pushNamed(context, '/form');
    setState(() => _futureReadList = api.fetchData());
  }

  void _openSetting() async {
    await Navigator.pushNamed(context, '/setting');
    setState(() => _futureReadList = api.fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => setState(() => _futureReadList = api.fetchData()),
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

            return ListView(
              children: readList
                  .map((readListItem) =>
                      ListTile(title: Text(readListItem.title)))
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
                    onPressed: _openSetting,
                    child: Text('Open Setting'),
                  ),
                ],
              ),
            );
          }

          return LoadingScreen();
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Setting'),
              onTap: () {
                Navigator.pop(context);
                _openSetting();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        tooltip: 'Add New List',
        child: Icon(Icons.add),
      ),
    );
  }
}
