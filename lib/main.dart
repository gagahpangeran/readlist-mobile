import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:readlist/pages/form.dart';
import 'package:readlist/pages/list.dart';
import 'package:readlist/pages/setting.dart';

void main() async {
  final HttpLink link = HttpLink('http://localhost:9000/graphql');

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  MyApp({required this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'Read List',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/list',
          routes: {
            '/list': (context) => ListPage(),
            '/form': (context) => FormPage(),
            '/setting': (content) => SettingPage(),
          },
        ),
      ),
    );
  }
}
