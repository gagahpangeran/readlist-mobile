import 'package:flutter/material.dart';
import 'package:readlist/utils/sort_filter.dart';

class SortFilterDialog extends StatefulWidget {
  final void Function(SortFilter) updateSortParameter;
  final SortFilter initialSortParameter;

  SortFilterDialog(this.updateSortParameter, this.initialSortParameter);

  @override
  _SortFilterDialogState createState() => _SortFilterDialogState();
}

class _SortFilterDialogState extends State<SortFilterDialog> {
  SortBy _sortBy;
  SortOrder _sortOrder;
  String _isRead;

  @override
  void initState() {
    super.initState();
    setState(() {
      _sortBy = widget.initialSortParameter.sortBy;
      _sortOrder = widget.initialSortParameter.sortOrder;
    });
  }

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
                      child: Text(value.text),
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
                selected: _sortOrder == SortOrder.Asc,
                onSelected: (_) => setState(() {
                  _sortOrder = SortOrder.Asc;
                }),
                avatar: Icon(Icons.arrow_downward),
              ),
              ChoiceChip(
                label: Text('Desc'),
                selected: _sortOrder == SortOrder.Desc,
                onSelected: (_) => setState(() {
                  _sortOrder = SortOrder.Desc;
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
            onPressed: () {
              setState(() {
                _sortOrder = SortFilter.defaultSortOrder;
                _sortBy = SortFilter.defaultSortBy;
              });
            },
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
                  widget.updateSortParameter(SortFilter(
                    sortBy: _sortBy,
                    sortOrder: _sortOrder,
                  ));
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
