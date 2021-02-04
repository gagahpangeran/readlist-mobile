import 'package:flutter/material.dart';
import 'package:readlist/components/custom_input_text.dart';
import 'package:readlist/models/setting.dart';
import 'package:readlist/utils/helper.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _formKey = GlobalKey<FormState>();
  final _apiKeyController = TextEditingController();
  final _gistIdController = TextEditingController();
  final _fileNameController = TextEditingController();

  Future<Setting> _futureSetting;

  Future<bool> _saveSetting() async {
    try {
      await Setting.create(
        apiKey: _apiKeyController.text,
        gistId: _gistIdController.text,
        fileName: _fileNameController.text,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  _onSubmit() {
    if (_formKey.currentState.validate()) {
      Helper.submitForm(
        context: context,
        submitFunction: _saveSetting,
        onSubmitText: 'Saving settings...',
        onSuccessText: 'Settings are saved',
        onErrorText: 'Error! Can\'t save settings',
      );
    }
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

            final textInputData = [
              {
                'controller': _apiKeyController,
                'icon': Icon(Icons.lock),
                'labelText': 'API Key',
                'validator': true,
                'initialValue': setting.apiKey,
              },
              {
                'controller': _gistIdController,
                'icon': Icon(Icons.link),
                'labelText': 'Gist ID',
                'validator': true,
                'initialValue': setting.gistId,
              },
              {
                'controller': _fileNameController,
                'icon': Icon(Icons.folder),
                'labelText': 'File Name',
                'validator': true,
                'initialValue': setting.fileName,
              }
            ];

            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...textInputData
                      .map((data) => CustomInputText(
                            controller: data['controller'],
                            icon: data['icon'],
                            labelText: data['labelText'],
                            validator: data['validator'],
                            initialValue: data['initialValue'],
                          ))
                      .toList(),
                  Center(
                    child: ElevatedButton(
                      onPressed: _onSubmit,
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
