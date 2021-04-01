import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readlist/models/read_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadListTile extends StatefulWidget {
  final ReadList readList;

  ReadListTile(this.readList);

  @override
  _ReadListTileState createState() => _ReadListTileState();
}

class _ReadListTileState extends State<ReadListTile> {
  final dateFormat = DateFormat('yyyy-MM-dd');

  _launchLink() async {
    final url = widget.readList.link;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isRead = widget.readList.readAt != null;
    return ListTile(
      title: Text(
        widget.readList.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      subtitle: Text(
        isRead
            ? "Read At : ${dateFormat.format(widget.readList.readAt!)}"
            : "Unread",
        style: isRead ? null : TextStyle(color: Colors.red),
      ),
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
