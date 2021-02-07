import 'package:flutter/foundation.dart';
import 'package:readlist/models/read_list_item.dart';

class SortFilter {
  static final defaultSortBy = SortBy.UpdatedAt;
  static final defaultSortOrder = SortOrder.Desc;
  static final defaultIsRead = IsRead.None;

  SortBy sortBy;
  SortOrder sortOrder;
  IsRead isRead;

  @override
  String toString() {
    return '''SortFilter {
sortBy: $sortBy
sortOrder: $sortOrder
isRead: $isRead
}''';
  }

  SortFilter({
    SortBy sortBy,
    SortOrder sortOrder,
    IsRead isRead,
  }) {
    this.sortBy = sortBy ?? defaultSortBy;
    this.sortOrder = sortOrder ?? defaultSortOrder;
    this.isRead = isRead ?? defaultIsRead;
  }

  static int Function(ReadListItem, ReadListItem) getComparator(
    SortBy sortBy,
    SortOrder sortOrder,
  ) {
    return (ReadListItem x, ReadListItem y) =>
        sortOrder.number *
        x.getValue(sortBy.val).compareTo(y.getValue(sortBy.val));
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

enum IsRead {
  Read,
  UnRead,
  None,
}

extension IsReadValue on IsRead {
  bool get val {
    switch (this) {
      case IsRead.Read:
        return true;
      case IsRead.UnRead:
        return false;
      case IsRead.None:
      default:
        return null;
    }
  }
}
