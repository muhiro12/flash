import 'package:flash/Main/main_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainArea extends StatelessWidget {
  MainArea(this._controller, this._focusNode);

  final TextEditingController _controller;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    double _margin = 10;
    return Column(
      children: <Widget>[
        Expanded(
          child: Card(
            margin: EdgeInsets.all(_margin),
            child: Container(
              margin: EdgeInsets.all(_margin),
              child: MainTextField(_controller, _focusNode),
            ),
          ),
        ),
        Visibility(
          visible: !_focusNode.hasFocus,
          child: Container(
            margin: EdgeInsets.only(
              left: _margin,
              right: _margin,
              bottom: _margin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: _clear,
                  tooltip: 'Clear',
                  child: Icon(Icons.delete_outline),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _clear() {
    _controller.clear();
  }
}
