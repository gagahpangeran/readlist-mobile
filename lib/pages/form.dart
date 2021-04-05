import 'package:flutter/material.dart';
import 'package:readlist/api/gist.dart';
import 'package:readlist/components/custom_input_text.dart';
import 'package:readlist/models/read_list_item.dart';
import 'package:readlist/utils/helper.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
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

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Helper.submitForm(
        context: context,
        submitFunction: _submitForm,
        onSubmitText: 'Submitting data...',
        onSuccessText: 'Success submit data!',
        onErrorText: 'Error! Can\'t submit data',
      );
    }
  }

  void _fetchTitle() async {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(Helper.buildSnackbar(text: 'Getting title...'));
    _titleController.text = await Helper.fetchTitle(_linkController.text);
    scaffold.hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    final textInputData = [
      new CustomInputTextData(
        controller: _linkController,
        icon: Icon(Icons.link),
        labelText: 'Link',
        validator: true,
        onPaste: _fetchTitle,
        onEditingComplete: _fetchTitle,
      ),
      new CustomInputTextData(
        controller: _titleController,
        icon: Icon(Icons.title),
        labelText: 'Title',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New List'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...textInputData
                .map((data) => CustomInputText(args: data))
                .toList(),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _isRead,
                  onChanged: (value) => setState(() => _isRead = value!),
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
