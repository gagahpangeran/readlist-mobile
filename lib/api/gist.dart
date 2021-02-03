import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:readlist/models/read_list_item.dart';
import 'package:readlist/models/setting.dart';

class GistAPI {
  final _apiEndpoint = 'https://api.github.com/gists';

  Future<bool> submitData(ReadListItem readListItem) async {
    final setting = await Setting.load();
    final savedData = await fetchData();

    savedData.add(readListItem);
    String jsonData =
        jsonEncode({'data': savedData.map((data) => data.toMap()).toList()});

    final response = await http.patch(
      '$_apiEndpoint/${setting.gistId}',
      headers: {'Authorization': 'token ${setting.apiKey}'},
      body: jsonEncode({
        'files': {
          '${setting.fileName}': {'content': jsonData}
        }
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ReadListItem>> fetchData() async {
    final setting = await Setting.load();

    final response = await http.get(
      '$_apiEndpoint/${setting.gistId}',
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

  List<ReadListItem> _parseData(String responseBody, String fileName) {
    var content = jsonDecode(responseBody)['files'][fileName]['content'];
    List<dynamic> data = jsonDecode(content)['data'];

    return data == null
        ? []
        : data.map((d) => ReadListItem.fromJson(d)).toList();
  }
}
