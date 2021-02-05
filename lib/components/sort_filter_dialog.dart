import 'package:flutter/material.dart';

class SortFilterDialog extends StatefulWidget {
  @override
  _SortFilterDialogState createState() => _SortFilterDialogState();
}

class _SortFilterDialogState extends State<SortFilterDialog> {
  String _dropdownValue = 'Created At';
  String _sortOrder = 'DESC';
  String _isRead;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Sort & Filter'),
      children: <Widget>[
        SimpleDialogOption(
          child: Text('Sort by'),
        ),
        SimpleDialogOption(
          child: DropdownButton(
            value: _dropdownValue,
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String newValue) {
              setState(() {
                _dropdownValue = newValue;
              });
            },
            items: <String>['Title', 'Updated At', 'Created At']
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
        ),
        SimpleDialogOption(
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            children: <Widget>[
              ChoiceChip(
                label: Text('ASC'),
                selected: _sortOrder == 'ASC',
                onSelected: (_) {
                  setState(() {
                    _sortOrder = 'ASC';
                  });
                },
                avatar: Icon(Icons.arrow_downward),
              ),
              ChoiceChip(
                label: Text('DESC'),
                selected: _sortOrder == 'DESC',
                onSelected: (_) {
                  setState(() {
                    _sortOrder = 'DESC';
                  });
                },
                avatar: Icon(Icons.arrow_upward),
              ),
            ],
          ),
        ),
        SimpleDialogOption(
          child: Text('Filter by'),
        ),
        SimpleDialogOption(
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            children: <Widget>[
              ChoiceChip(
                label: Text('Read'),
                selected: _isRead == 'read',
                onSelected: (_) {
                  setState(() {
                    _isRead = _isRead == 'read' ? null : 'read';
                  });
                },
                avatar: Icon(Icons.check),
              ),
              ChoiceChip(
                label: Text('Unread'),
                selected: _isRead == 'unread',
                onSelected: (_) {
                  setState(() {
                    _isRead = _isRead == 'unread' ? null : 'unread';
                  });
                },
                avatar: Icon(Icons.close),
              ),
            ],
          ),
        ),
        SimpleDialogOption(
          child: OutlineButton(
            onPressed: () {},
            child: Text('Reset all to default'),
            textColor: Colors.red,
          ),
        ),
        SimpleDialogOption(
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Apply'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
