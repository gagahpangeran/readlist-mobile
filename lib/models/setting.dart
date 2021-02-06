import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting {
  String _apiKey;
  String _gistId;
  String _fileName;

  Setting._(this._apiKey, this._gistId, this._fileName);

  String get apiKey => _apiKey;
  String get gistId => _gistId;
  String get fileName => _fileName;

  static Future<Setting> create({
    @required String apiKey,
    @required String gistId,
    @required String fileName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('apiKey', apiKey);
    prefs.setString('gistId', gistId);
    prefs.setString('fileName', fileName);

    return Setting._(apiKey, gistId, fileName);
  }

  static Future<Setting> load() async {
    final prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.getString('apiKey');
    String gistId = prefs.getString('gistId');
    String fileName = prefs.getString('fileName');

    return Setting._(apiKey, gistId, fileName);
  }
}
