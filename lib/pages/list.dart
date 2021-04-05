import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:readlist/components/read_list_tile.dart';
import 'package:readlist/models/read_list.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final String _allReadListsQuery = """
    query AllReadLists {
      allReadLists(
        skip: 0
        limit: 10
        sort: { order: DESC, fields: readAt }
        filter: { readAt: { isNull: false } }
      ) {
        id
        title
        link
        readAt
        comment
      }
    }
  """;

  void _openView(String route) async {
    await Navigator.pushNamed(context, route);
  }

  PreferredSizeWidget _buildMainAppBar() {
    return AppBar(
      title: Text('Read List'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () => _openView('/auth'),
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _refetch,
        )
      ],
    );
  }

  Widget _buildBody(QueryResult result) {
    if (result.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (result.hasException) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Can't fetch data!"),
            Text("Make sure you are connected to internet."),
          ],
        ),
      );
    }

    List<dynamic> allReadListsJson = result.data!['allReadLists'];
    List<ReadList> allReadLists = allReadListsJson
        .map((readList) => ReadList.fromJson(readList))
        .toList();

    if (allReadLists.isEmpty) {
      return Center(child: Text("No Data!"));
    }

    return ListView(
      children: allReadLists.map((readList) => ReadListTile(readList)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(_allReadListsQuery)),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        return Scaffold(
          appBar: _buildMainAppBar(),
          body: _buildBody(result),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _openView('/form'),
            tooltip: 'Add New List',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
