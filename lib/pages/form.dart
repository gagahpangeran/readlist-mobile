import 'package:flutter/material.dart';
import 'package:readlist/api/gist.dart';
import 'package:readlist/models/read_list_item.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String _link;
  String _title;
  bool _isRead = true;

  GistAPI api = GistAPI();

  Future<bool> _submitForm() async {
    final readListItem = ReadListItem(
      link: _link,
      title: _title,
      isRead: _isRead,
    );

    try {
      await api.submitData(readListItem);
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget _buildSnackbar({
    @required String text,
    void Function() action,
    String actionLabel,
  }) {
    return SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      action: action == null
          ? null
          : SnackBarAction(label: actionLabel, onPressed: action),
    );
  }

  _onSubmit() async {
    final scaffold = ScaffoldMessenger.of(context);

    final submitSnackbar = _buildSnackbar(text: 'Submitting data...');

    final errorSnackbar = _buildSnackbar(
      text: 'Error! Can\'t submit data',
      action: () => scaffold.hideCurrentSnackBar(),
      actionLabel: 'Close',
    );

    final successSnackbar = _buildSnackbar(text: 'Success submit data!');

    scaffold.showSnackBar(submitSnackbar);
    bool success = await _submitForm();
    scaffold.hideCurrentSnackBar();
    if (success) {
      scaffold.showSnackBar(successSnackbar);
      Navigator.pop(context);
    } else {
      scaffold.showSnackBar(errorSnackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New List'),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.link),
                labelText: 'Link',
              ),
              onChanged: (value) => setState(() => _link = value),
              validator: (value) =>
                  value.isEmpty ? 'Please enter the link' : null,
            ),
            TextFormField(
              onChanged: (value) => setState(() => _title = value),
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                labelText: 'Title',
              ),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _isRead,
                  onChanged: (value) => setState(() => _isRead = value),
                ),
                Text('Already Read'),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: _onSubmit,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
