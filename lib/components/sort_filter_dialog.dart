import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readlist/utils/sort_filter.dart';

class SortFilterDialog extends StatefulWidget {
  final void Function(Map<String, Object>) updateSortParameter;

  SortFilterDialog(this.updateSortParameter);

  @override
  _SortFilterDialogState createState() => _SortFilterDialogState();
}

class _SortFilterDialogState extends State<SortFilterDialog> {
  SortBy _sortBy = SortFilter.defaultSortBy;
  SortOrder _sortOrder = SortFilter.defaultSortOrder;
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
          child: DropdownButton<SortBy>(
            value: _sortBy,
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (newValue) => setState(() {
              _sortBy = newValue;
            }),
            items: <SortBy>[...SortBy.values]
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(describeEnum(value)),
                    ))
                .toList(),
          ),
        ),
        SimpleDialogOption(
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            children: <Widget>[
              ChoiceChip(
                label: Text('Asc'),
                selected: _sortOrder == SortOrder.asc,
                onSelected: (_) => setState(() {
                  _sortOrder = SortOrder.asc;
                }),
                avatar: Icon(Icons.arrow_downward),
              ),
              ChoiceChip(
                label: Text('Desc'),
                selected: _sortOrder == SortOrder.desc,
                onSelected: (_) => setState(() {
                  _sortOrder = SortOrder.desc;
                }),
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
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.updateSortParameter({
                    'sortOrder': _sortOrder,
                    'sortBy': _sortBy,
                  });
                  Navigator.pop(context);
                },
                child: Text('Apply'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
