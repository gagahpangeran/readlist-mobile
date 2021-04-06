import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GQLWrapper extends StatefulWidget {
  final Widget app;

  GQLWrapper({required this.app});

  @override
  _GQLWrapperState createState() => _GQLWrapperState();
}

class _GQLWrapperState extends State<GQLWrapper> {
  String _serverLink =
      Platform.environment['GRAPHQL'] ?? "http://localhost:9000/graphql";

  late Future<Map<String, String>?> _futureAuthData;

  Future<Map<String, String>?> _getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? username = prefs.getString("username");

    if (token != null && username != null) {
      return {
        'token': token,
        'username': username,
      };
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _futureAuthData = _getAuthData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>?>(
      future: _futureAuthData,
      builder: (context, snapshot) {
        Link? link;
        final HttpLink httpLink = HttpLink(_serverLink);

        if (snapshot.hasData && snapshot.data != null) {
          String? token = snapshot.data!['token'];

          if (token != null) {
            link = AuthLink(getToken: () => 'Bearer $token').concat(httpLink);
          }
        }

        if (link == null) {
          link = httpLink;
        }

        ValueNotifier<GraphQLClient> client = ValueNotifier(
          GraphQLClient(
            link: link,
            cache: GraphQLCache(store: InMemoryStore()),
          ),
        );

        return GraphQLProvider(
          client: client,
          child: CacheProvider(
            child: widget.app,
          ),
        );
      },
    );
  }
}
