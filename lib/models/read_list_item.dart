import 'package:uuid/uuid.dart';

class ReadListItem {
  String _id;
  String _link;
  String _title;
  bool _isRead;
  DateTime _createdAt;
  DateTime _updatedAt;

  ReadListItem({id, link, title, isRead, createdAt, updatedAt}) {
    if (link == null) {
      throw new ArgumentError.notNull('"link" can not be null');
    }

    _id = id ?? Uuid().v1();
    _link = link;
    _title = title ?? link;
    _isRead = isRead ?? true;
    _createdAt = createdAt ?? new DateTime.now();
    _updatedAt = updatedAt ?? _createdAt;
  }

  String get title => _title;

  factory ReadListItem.fromJson(Map<String, dynamic> json) => new ReadListItem(
        id: json['id'],
        link: json['link'],
        isRead: json['isRead'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  @override
  String toString() {
    return '''ReadListItem {
  id: $_id
  link: $_link
  title: $_title
  isRead: $_isRead
  createdAt: $_createdAt
  updatedAt: $_updatedAt
}''';
  }
}
