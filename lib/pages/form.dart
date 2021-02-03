import 'package:flutter/material.dart';
import 'package:readlist/api/gist.dart';
import 'package:readlist/models/read_list_item.dart';
import 'package:readlist/utils/helper.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _linkController = TextEditingController();
  final _titleController = TextEditingController();
  bool _isRead = true;

  Future<bool> _submitForm() async {
    final readListItem = ReadListItem(
      link: _linkController.text,
      title: _titleController.text,
      isRead: _isRead,
    );

    try {
      await GistAPI.submitData(readListItem);
      return true;
    } catch (e) {
      return false;
    }
  }

  _onSubmit() {
    Helper.submitForm(
      context: context,
      submitFunction: _submitForm,
      onSubmitText: 'Submitting data...',
      onSuccessText: 'Success submit data!',
      onErrorText: 'Error! Can\'t submit data',
    );
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
              controller: _linkController,
              decoration: const InputDecoration(
                icon: Icon(Icons.link),
                labelText: 'Link',
              ),
              validator: (value) =>
                  value.isEmpty ? 'Please enter the link' : null,
            ),
            TextFormField(
              controller: _titleController,
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
