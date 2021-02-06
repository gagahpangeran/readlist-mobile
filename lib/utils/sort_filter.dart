import 'package:flutter/foundation.dart';
import 'package:readlist/models/read_list_item.dart';

class SortFilter {
  static final defaultSortBy = SortBy.updatedAt;
  static final defaultSortOrder = SortOrder.desc;

  static int Function(ReadListItem, ReadListItem) _getComparator(
    SortBy sortBy,
    SortOrder sortOrder,
  ) {
    return (ReadListItem x, ReadListItem y) =>
        (sortOrder == SortOrder.asc ? 1 : -1) *
        x
            .toMap()[describeEnum(sortBy)]
            .compareTo(y.toMap()[describeEnum(sortBy)]);
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
  title,
  updatedAt,
  createdAt,
}

enum SortOrder {
  asc,
  desc,
}
