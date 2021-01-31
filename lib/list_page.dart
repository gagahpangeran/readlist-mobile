import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, String>> data = [
    {'url': 'http://test1', 'title': 'Ini tes'},
    {'url': 'http://test2', 'title': 'http://test2'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read List'),
      ),
      body: ListView(
        children: data
            .map((d) => ListTile(
                  title: Text(d['title']),
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/form');
        },
        tooltip: 'Add New List',
        child: Icon(Icons.add),
      ),
    );
  }
}
