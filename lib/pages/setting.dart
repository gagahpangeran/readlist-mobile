import 'package:flutter/material.dart';
import 'package:readlist/components/loading_screen.dart';
import 'package:readlist/models/setting.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _apiKey;
  String _gistId;
  String _fileName;

  Future<Setting> futureSetting;

  void _saveSetting() {
    Setting.create(
      apiKey: _apiKey,
      gistId: _gistId,
      fileName: _fileName,
    );
  }

  @override
  void initState() {
    super.initState();
    futureSetting = Setting.load();
  }

  @override
  Widget build(BuildContext context) {
    print('build widget');
    return Scaffold(
        appBar: AppBar(
          title: Text('Set Up Gist Database'),
        ),
        body: FutureBuilder<Setting>(
          future: futureSetting,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var setting = snapshot.data;

              return Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.lock), labelText: 'API Key'),
                      onChanged: (value) => setState(() => _apiKey = value),
                      validator: (value) =>
                          value.isEmpty ? 'Please enter the API key' : null,
                      initialValue: setting.apiKey,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.link), labelText: 'Gist ID'),
                      onChanged: (value) => setState(() => _gistId = value),
                      validator: (value) =>
                          value.isEmpty ? 'Please enter the Gist ID' : null,
                      initialValue: setting.gistId,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.folder), labelText: 'File Name'),
                      onChanged: (value) => setState(() => _fileName = value),
                      validator: (value) =>
                          value.isEmpty ? 'Please enter the file name' : null,
                      initialValue: setting.fileName,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveSetting,
                        child: Text('Save'),
                      ),
                    ),
                  ],
                ),
              );
            }

            return LoadingScreen();
          },
        ));
  }
}
