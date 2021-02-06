import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:readlist/models/read_list_item.dart';
import 'package:readlist/models/sort_filter.dart';

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

  static Future<String> fetchTitle(String link) async {
    final response = await http.get(link);
    String title = parse(response.body).querySelector('title').text;
    return title;
  }

  static List<ReadListItem> immutableSort(
    List<ReadListItem> list,
    SortFilter sortParam,
  ) {
    var newList = [...list];
    var comparator =
        SortFilter.getComparator(sortParam.sortBy, sortParam.sortOrder);
    newList.sort(comparator);
    return newList;
  }

  static List<ReadListItem> advancedFilter(
    List<ReadListItem> list,
    SortFilter filterParam,
  ) {
    if (filterParam.isRead.val == null) {
      return list;
    }

    return list.where((item) => item.isRead == filterParam.isRead.val).toList();
  }
}
