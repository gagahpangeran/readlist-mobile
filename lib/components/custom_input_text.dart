import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CustomInputText extends StatefulWidget {
  final CustomInputTextData args;

  CustomInputText({required this.args});

  @override
  _CustomInputTextState createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  bool _isEmpty = true;

  void _onPressed() async {
    if (_isEmpty) {
      ClipboardData clipboardData =
          await Clipboard.getData('text/plain') as ClipboardData;
      widget.args.controller.text = clipboardData.text!;
      widget.args.onPaste!();
    } else {
      widget.args.controller.text = '';
      widget.args.onClear!();
    }
  }

  String? Function(String?)? _getValidator() {
    if (widget.args.validator) {
      return (String? value) =>
          value!.isEmpty ? '${widget.args.labelText} can\'t be empty' : null;
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isEmpty = widget.args.controller.text.isEmpty;
    });
    widget.args.controller.addListener(() {
      setState(() {
        _isEmpty = widget.args.controller.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.args.password,
      controller: widget.args.controller,
      decoration: InputDecoration(
        icon: widget.args.icon,
        labelText: widget.args.labelText,
        suffixIcon: IconButton(
          icon: Icon(_isEmpty ? Icons.paste : Icons.clear),
          onPressed: _onPressed,
        ),
      ),
      onEditingComplete: widget.args.onEditingComplete,
      validator: _getValidator(),
    );
  }
}

class CustomInputTextData {
  final TextEditingController controller;
  final String? labelText;
  final String? initialValue;
  final Icon? icon;
  final void Function()? onPaste;
  final void Function()? onClear;
  final void Function()? onEditingComplete;
  final bool validator;
  final bool password;

  CustomInputTextData({
    required this.controller,
    this.labelText,
    this.initialValue,
    this.icon,
    this.onPaste,
    this.onClear,
    this.onEditingComplete,
    this.validator = false,
    this.password = false,
  }) {
    controller.text = initialValue ?? "";
  }
}
