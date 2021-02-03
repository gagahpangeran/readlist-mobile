import 'package:flutter/material.dart';
import 'package:readlist/models/setting.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _apiKeyController = TextEditingController();
  final _gistIdController = TextEditingController();
  final _fileNameController = TextEditingController();

  Future<Setting> _futureSetting;

  void _saveSetting() {
    setState(() {
      _futureSetting = Setting.create(
        apiKey: _apiKeyController.text,
        gistId: _gistIdController.text,
        fileName: _fileNameController.text,
      );
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _futureSetting = Setting.load();
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _gistIdController.dispose();
    _fileNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Up Gist Database'),
      ),
      body: FutureBuilder<Setting>(
        future: _futureSetting,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var setting = snapshot.data;
            _apiKeyController.text = setting.apiKey;
            _gistIdController.text = setting.gistId;
            _fileNameController.text = setting.fileName;

            return Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _apiKeyController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'API Key',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Please enter the API key' : null,
                  ),
                  TextFormField(
                    controller: _gistIdController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.link),
                      labelText: 'Gist ID',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Please enter the Gist ID' : null,
                  ),
                  TextFormField(
                    controller: _fileNameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.folder),
                      labelText: 'File Name',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Please enter the file name' : null,
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

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
