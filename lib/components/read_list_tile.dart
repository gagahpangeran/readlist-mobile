import 'package:flutter/material.dart';
import 'package:readlist/models/read_list_item.dart';

class ReadListTile extends StatefulWidget {
  final ReadListItem item;

  const ReadListTile(this.item) : assert(item != null);

  @override
  _ReadListTileState createState() => _ReadListTileState();
}

class _ReadListTileState extends State<ReadListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16.0,
      title: Text(widget.item.title),
      trailing: widget.item.isRead
          ? Icon(
              Icons.check,
              color: Colors.blue,
            )
          : null,
    );
  }
}
