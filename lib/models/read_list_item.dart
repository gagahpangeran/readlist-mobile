import 'package:uuid/uuid.dart';

class ReadListItem {
  late String _id;
  late String _link;
  late String _title;
  late bool _isRead;
  late DateTime _createdAt;
  late DateTime _updatedAt;

  ReadListItem({
    required String link,
    String? id,
    String? title,
    bool? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    _id = id ?? Uuid().v1();
    _link = link;
    _title = title == null || title.isEmpty ? link : title;
    _isRead = isRead ?? true;
    _createdAt = createdAt ?? new DateTime.now();
    _updatedAt = updatedAt ?? _createdAt;
  }

  String get id => _id;
  String get link => _link;
  String get title => _title;
  bool get isRead => _isRead;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;

  dynamic getValue(String property) {
    var propList = ['id', 'link', 'title', 'isRead', 'createdAt', 'updatedAt'];
    if (!propList.contains(property)) {
      throw ArgumentError.value("No such property in this object");
    }

    return this.toMap()[property];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'link': link,
      'title': title,
      'isRead': isRead,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ReadListItem.fromJson(Map<String, dynamic> json) {
    return new ReadListItem(
      id: json['id'],
      link: json['link'],
      title: json['title'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return '''ReadListItem {
  id: $id
  link: $link
  title: $title
  isRead: $isRead
  createdAt: ${createdAt.toLocal()}
  updatedAt: ${updatedAt.toLocal()}
}''';
  }
}
