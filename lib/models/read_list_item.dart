import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ReadListItem {
  String _id;
  String _link;
  String _title;
  bool _isRead;
  DateTime _createdAt;
  DateTime _updatedAt;

  ReadListItem({
    @required String link,
    String id,
    String title,
    bool isRead,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    _id = id ?? Uuid().v1();
    _link = link;
    _title = title ?? link;
    _isRead = isRead ?? true;
    _createdAt = createdAt ?? new DateTime.now();
    _updatedAt = updatedAt ?? _createdAt;
  }

  String get id => _id;
  String get link => _link;
  String get title => _title;
  bool get isRead => _isRead;
  String get createdAt => _createdAt.toString();
  String get updatedAt => _updatedAt.toString();

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'link': _link,
      'title': _title,
      'isRead': _isRead,
      'createdAt': _createdAt.toIso8601String(),
      'updatedAt': _updatedAt.toIso8601String(),
    };
  }

  factory ReadListItem.fromJson(Map<String, dynamic> json) => new ReadListItem(
        id: json['id'],
        link: json['link'],
        title: json['title'],
        isRead: json['isRead'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
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
