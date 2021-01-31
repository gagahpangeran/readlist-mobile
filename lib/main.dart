import 'package:flutter/material.dart';
import 'package:readlist/index_page.dart';
import 'package:readlist/list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Read List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => IndexPage(),
        '/list': (context) => ListPage(),
      },
    );
  }
}
