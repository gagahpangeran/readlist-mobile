import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:readlist/models/read_list_item.dart';

class GistAPI {
  String _rawGistLink = 'https:/secret.com/data.json';
  String _apiKey = 'secret';

  GistAPI();

  void submitData(ReadListItem readListItem) {}

  Future<List<ReadListItem>> fetchData() async {
    final response = await http.get(_rawGistLink);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return data == null ? List() : ReadListItem.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
