import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readlist/models/read_list_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadListTile extends StatefulWidget {
  final ReadListItem item;

  ReadListTile(this.item);

  @override
  _ReadListTileState createState() => _ReadListTileState();
}

class _ReadListTileState extends State<ReadListTile> {
  final format = DateFormat('yyyy-MM-dd, HH:mm:ss');

  _launchLink() async {
    final url = widget.item.link;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: widget.item.isRead ? null : Colors.red[100],
      minVerticalPadding: 16.0,
      title: Text(widget.item.title),
      subtitle: Text("""Updated At : ${format.format(widget.item.updatedAt)}
Created At : ${format.format(widget.item.createdAt)}"""),
      trailing: IconButton(
        icon: Icon(
          Icons.open_in_new,
          color: Colors.blue,
        ),
        onPressed: _launchLink,
      ),
    );
  }
}
