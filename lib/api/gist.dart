import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:readlist/models/read_list_item.dart';

class GistAPI {


  String _gistId = 'secret';
  String _apiEndpoint = 'https://api.github.com/gists';

  Map<String, String> headers = {
    'Authorization': 'token secret',
  };

  void submitData(ReadListItem readListItem) async {
    final savedData = await fetchData();
    savedData.add(readListItem);

    String jsonData =
        jsonEncode({'data': savedData.map((data) => data.toMap()).toList()});

    final response = await http.patch(
      '$_apiEndpoint/$_gistId',
      headers: headers,
      body: jsonEncode({
        'files': {
          'data.json': {'content': jsonData}
        }
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
    } else {
      throw Exception('Failed to submit data');
    }
  }

  Future<List<ReadListItem>> fetchData() async {
    final res = await http.get('$_apiEndpoint/$_gistId', headers: headers);

    if (res.statusCode == 200) {
      var content = jsonDecode(res.body)['files']['data.json']['content'];
      List<dynamic> data = jsonDecode(content)['data'];

      return data == null
          ? List()
          : data.map((d) => ReadListItem.fromJson(d)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
