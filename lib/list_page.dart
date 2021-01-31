import 'package:flutter/material.dart';
import 'package:readlist/read_list_item_model.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<ReadListItem> readList = [
    new ReadListItem(link: 'https://testes.co', title: 'Test hehe'),
    new ReadListItem(link: 'http://hello.hhh'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read List'),
      ),
      body: ListView(
        children: readList
            .map((readListItem) => ListTile(
                  title: Text(readListItem.title),
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/form'),
        tooltip: 'Add New List',
        child: Icon(Icons.add),
      ),
    );
  }
}
