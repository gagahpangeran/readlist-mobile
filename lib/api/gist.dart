import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:readlist/models/read_list_item.dart';
import 'package:readlist/models/setting.dart';

class GistAPI {
  static final _apiEndpoint = 'https://api.github.com/gists';

  GistAPI._();

  static Future<List<ReadListItem>> submitData(
      ReadListItem readListItem) async {
    final setting = await Setting.load();
    final savedData = await fetchData();

    savedData.add(readListItem);
    String jsonData = jsonEncode(
      {'data': savedData.map((data) => data.toMap()).toList()},
      toEncodable: (item) => item is DateTime ? item.toIso8601String() : item,
    );

    final response = await http.patch(
      Uri.parse('$_apiEndpoint/${setting.gistId}'),
      headers: {'Authorization': 'token ${setting.apiKey}'},
      body: jsonEncode({
        'files': {
          '${setting.fileName}': {'content': jsonData}
        }
      }),
    );

    if (response.statusCode == 200) {
      return _parseData(response.body, setting.fileName);
    } else {
      throw Exception('Failed to submit data');
    }
  }

  static Future<List<ReadListItem>> fetchData() async {
    final setting = await Setting.load();

    final response = await http.get(
      Uri.parse('$_apiEndpoint/${setting.gistId}'),
      headers: {
        'Authorization': 'token ${setting.apiKey}',
      },
    );

    if (response.statusCode == 200) {
      return _parseData(response.body, setting.fileName);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  static List<ReadListItem> _parseData(String responseBody, String? fileName) {
    var content = jsonDecode(responseBody)['files'][fileName]['content'];
    List<dynamic>? data = jsonDecode(content)['data'];

    return data == null
        ? []
        : data.map((d) => ReadListItem.fromJson(d)).toList();
  }
}
