import 'package:flash/Main/main_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
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
                IconButton(
                  icon: Icon(Icons.content_copy),
                  tooltip: 'Copy',
                  onPressed: _copy,
                ),
                Container(
                  width: _margin,
                ),
                IconButton(
                  icon: Icon(Icons.content_paste),
                  tooltip: 'Paste',
                  onPressed: _paste,
                ),
                Container(
                  width: _margin,
                ),
                FloatingActionButton(
                  tooltip: 'Clear',
                  onPressed: _clear,
                  child: Icon(
                    Icons.delete_outline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _copy() async {
    final data = ClipboardData(text: _controller.text);
    await Clipboard.setData(data);
  }

  void _paste() async {
    final data = await Clipboard.getData('text/plain');
    _controller.text += data.text;
  }

  void _clear() {
    _controller.clear();
  }
}
