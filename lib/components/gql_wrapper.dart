import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GQLWrapper extends StatefulWidget {
  final Widget app;

  GQLWrapper({required this.app});

  @override
  _GQLWrapperState createState() => _GQLWrapperState();
}

class _GQLWrapperState extends State<GQLWrapper> {
  String _serverLink =
      Platform.environment['GRAPHQL'] ?? "http://localhost:9000/graphql";

  @override
  Widget build(BuildContext context) {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: HttpLink(_serverLink),
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: widget.app,
      ),
    );
  }
}
