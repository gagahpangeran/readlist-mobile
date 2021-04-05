import 'package:flutter/material.dart';
import 'package:readlist/components/gql_wrapper.dart';
import 'package:readlist/pages/form.dart';
import 'package:readlist/pages/list.dart';
import 'package:readlist/pages/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GQLWrapper(
      app: MaterialApp(
        title: 'Read List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/list',
        routes: {
          '/list': (context) => ListPage(),
          '/form': (context) => FormPage(),
          '/auth': (content) => AuthPage(),
        },
      ),
    );
  }
}
