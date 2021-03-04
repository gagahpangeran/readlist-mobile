import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readlist/models/sort_filter.dart';

class SortFilterDialog extends StatefulWidget {
  final void Function(SortFilter) updateSortParameter;
  final SortFilter initialParam;

  SortFilterDialog(this.updateSortParameter, this.initialParam);

  @override
  _SortFilterDialogState createState() => _SortFilterDialogState();
}

class _SortFilterDialogState extends State<SortFilterDialog> {
  SortFilter _param;

  @override
  void initState() {
    super.initState();
    setState(() {
      _param = widget.initialParam;
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
            value: _param.sortBy,
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (newValue) => setState(() {
              _param.sortBy = newValue;
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
              children: <SortOrder>[...SortOrder.values]
                  .map(
                    (value) => ChoiceChip(
                      label: Text(describeEnum(value)),
                      selected: _param.sortOrder == value,
                      onSelected: (_) => setState(() {
                        _param.sortOrder = value;
                      }),
                      avatar: Icon(
                        value.number == 1
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                      ),
                    ),
                  )
                  .toList()),
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
                selected: _param.isRead == IsRead.Read,
                onSelected: (_) => setState(() {
                  _param.isRead =
                      _param.isRead == IsRead.Read ? IsRead.None : IsRead.Read;
                }),
                avatar: Icon(Icons.check),
              ),
              ChoiceChip(
                label: Text('Unread'),
                selected: _param.isRead == IsRead.UnRead,
                onSelected: (_) => setState(() {
                  _param.isRead = _param.isRead == IsRead.UnRead
                      ? IsRead.None
                      : IsRead.UnRead;
                }),
                avatar: Icon(Icons.close),
              ),
            ],
          ),
        ),
        SimpleDialogOption(
          child: OutlinedButton(
            child: Text('Reset all to default'),
            style: OutlinedButton.styleFrom(
              primary: Colors.red,
            ),
            onPressed: () => setState(() {
              _param = SortFilter();
            }),
          ),
        ),
        SimpleDialogOption(
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.updateSortParameter(_param);
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
