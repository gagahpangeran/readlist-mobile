import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:readlist/components/custom_input_text.dart';
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

  final String _addReadListMutation = """
  mutation AddReadList(\$link: String!, \$title: String!, \$readAt: DateTime) {
    addReadList(data: {
      link: \$link
      title: \$title
      readAt: \$readAt
    }) {
      id
    }
  }
  """;

  void _onSubmitButtonPressed(RunMutation runMutation) {
    if (_formKey.currentState!.validate()) {
      final scaffold = ScaffoldMessenger.of(context);
      final onLoginSnackbar = Helper.buildSnackbar(text: "Submitting...");
      scaffold.showSnackBar(onLoginSnackbar);

      runMutation({
        'link': _linkController.text,
        'title': _titleController.text,
        'readAt': _isRead ? (new DateTime.now()).toIso8601String() : null,
      });
    }
  }

  void _onAddSuccess(dynamic data) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.hideCurrentSnackBar();

    final successSnackbar = Helper.buildSnackbar(text: "Success submit data!");
    scaffold.showSnackBar(successSnackbar);
    Navigator.pop(context);
  }

  void _onAddError(OperationException? error) {
    // TODO: logging the error to somewhere
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.hideCurrentSnackBar();

    final errorSnackbar =
        Helper.buildSnackbar(text: "Error, there is something wrong!");
    scaffold.showSnackBar(errorSnackbar);
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
        validator: true,
      ),
    ];

    return Mutation(
      options: MutationOptions(
        document: gql(_addReadListMutation),
        onCompleted: _onAddSuccess,
        onError: _onAddError,
      ),
      builder: (
        RunMutation runMutation,
        QueryResult? result,
      ) {
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
                    onPressed: () => _onSubmitButtonPressed(runMutation),
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
