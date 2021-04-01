class ReadList {
  String id;
  String link;
  String title;
  DateTime? readAt;
  String? comment;

  ReadList({
    required this.id,
    required this.link,
    required this.title,
    this.readAt,
    this.comment,
  });

  factory ReadList.fromJson(Map<String, dynamic> json) {
    return new ReadList(
      id: json['id'],
      link: json['link'],
      title: json['title'],
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
      comment: json['comment'],
    );
  }

  @override
  String toString() {
    return '''ReadListItem {
  id: $id
  link: $link
  title: $title
  readAt: $readAt
  comment: $comment
}''';
  }
}
