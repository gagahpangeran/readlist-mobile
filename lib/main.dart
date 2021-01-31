import 'package:flutter/material.dart';
import 'package:readlist/pages/form.dart';
import 'package:readlist/pages/index.dart';
import 'package:readlist/pages/list.dart';

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
        '/form': (context) => FormPage(),
      },
    );
  }
}
