import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class CustomInputText extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String initialValue;
  final Icon icon;
  final void Function() onPaste;
  final void Function() onClear;
  final void Function() onEditingComplete;
  final bool validator;

  CustomInputText({
    @required this.controller,
    this.labelText,
    this.initialValue,
    this.icon,
    this.onPaste,
    this.onClear,
    this.onEditingComplete,
    this.validator = false,
  }) {
    assert(controller != null);
    controller.text = initialValue;
  }

  @override
  _CustomInputTextState createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  bool _isEmpty = true;

  _onPressed() {
    if (_isEmpty) {
      FlutterClipboard.paste().then((value) {
        widget.controller.text = value;
        widget.onPaste();
      });
    } else {
      widget.controller.text = '';
      widget.onClear();
    }
  }

  Function(String) _getValidator() {
    if (widget.validator) {
      return (String value) =>
          value.isEmpty ? '${widget.labelText} can\'t be empty' : null;
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isEmpty = widget.controller.text.isEmpty;
    });
    widget.controller.addListener(() {
      setState(() {
        _isEmpty = widget.controller.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        icon: widget.icon,
        labelText: widget.labelText,
        suffixIcon: IconButton(
          icon: Icon(_isEmpty ? Icons.paste : Icons.clear),
          onPressed: _onPressed,
        ),
      ),
      onEditingComplete: widget.onEditingComplete,
      validator: _getValidator(),
    );
  }
}
