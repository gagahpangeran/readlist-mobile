import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Helper {
  Helper._();

  static SnackBar buildSnackbar({
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

  static void submitForm({
    @required BuildContext context,
    @required Future<bool> submitFunction(),
    @required String onSubmitText,
    @required String onSuccessText,
    @required String onErrorText,
  }) async {
    final scaffold = ScaffoldMessenger.of(context);
    final onSubmitSnackbar = buildSnackbar(text: onSubmitText);
    final onSuccessSnackbar = buildSnackbar(text: onSuccessText);
    final onErrorSnackbar = buildSnackbar(
      text: onErrorText,
      action: () => scaffold.hideCurrentSnackBar(),
      actionLabel: 'Close',
    );

    scaffold.showSnackBar(onSubmitSnackbar);
    bool success = await submitFunction();
    scaffold.hideCurrentSnackBar();
    if (success) {
      scaffold.showSnackBar(onSuccessSnackbar);
      Navigator.pop(context);
    } else {
      scaffold.showSnackBar(onErrorSnackbar);
    }
  }
}
