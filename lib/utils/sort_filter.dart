import 'package:flutter/foundation.dart';
import 'package:readlist/models/read_list_item.dart';

class SortFilter {
  static final defaultSortBy = SortBy.UpdatedAt;
  static final defaultSortOrder = SortOrder.Desc;

  static int Function(ReadListItem, ReadListItem) _getComparator(
    SortBy sortBy,
    SortOrder sortOrder,
  ) {
    return (ReadListItem x, ReadListItem y) =>
        sortOrder.number *
        x.getValue(sortBy.val).compareTo(y.getValue(sortBy.val));
  }

  static List<ReadListItem> sort(
    List<ReadListItem> readList,
    SortBy sortBy,
    SortOrder sortOrder,
  ) {
    var newReadList = [...readList];
    newReadList.sort(_getComparator(sortBy, sortOrder));
    return newReadList;
  }
}

enum SortBy {
  Title,
  UpdatedAt,
  CreatedAt,
}

extension SortByStringify on SortBy {
  String get val {
    var str = describeEnum(this);
    return str[0].toLowerCase() + str.substring(1);
  }

  String get text {
    var str = describeEnum(this);
    var re = RegExp('([a-z])([A-Z]+)');
    return str.replaceAllMapped(re, (Match m) => '${m[1]} ${m[2]}');
  }
}

enum SortOrder {
  Asc,
  Desc,
}

extension SortOrderValue on SortOrder {
  int get number => this == SortOrder.Asc ? 1 : -1;
}
