import 'package:flash/main/main_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainTextField extends StatelessWidget {
  MainTextField(this._controller, this._focusNode);

  final TextEditingController _controller;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    _controller.text = Provider.of<MainText>(context).getValue();
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      buildCounter: _counter,
      toolbarOptions: ToolbarOptions(
        copy: true,
        cut: true,
        paste: true,
        selectAll: true,
      ),
      expands: true,
      maxLines: null,
    );
  }

  Widget _counter(
    BuildContext context, {
    int currentLength,
    int maxLength,
    bool isFocused,
  }) {
    return Text(
      '$currentLength characters',
      textAlign: TextAlign.end,
      style: TextStyle(color: Theme.of(context).accentColor),
    );
  }
}
