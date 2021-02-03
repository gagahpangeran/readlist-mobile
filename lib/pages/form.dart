import 'package:flutter/material.dart';
import 'package:readlist/api/gist.dart';
import 'package:readlist/components/loading_screen.dart';
import 'package:readlist/models/read_list_item.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String _link;
  String _title;
  bool _isRead = true;
  bool _isLoading = false;

  GistAPI api = GistAPI();

  _submitForm() async {
    setState(() => _isLoading = true);
    final readListItem = ReadListItem(
      link: _link,
      title: _title,
      isRead: _isRead,
    );
    bool success = await api.submitData(readListItem);

    if (success) {
      Navigator.pop(context);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New List'),
      ),
      body: Form(
        child: _isLoading
            ? LoadingScreen()
            : Column(
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
                      onPressed: () => _submitForm(),
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
