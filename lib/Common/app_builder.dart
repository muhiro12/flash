import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBuilder extends StatefulWidget {
  const AppBuilder({Key key, this.builder}) : super(key: key);

  final Function(BuildContext) builder;

  static _AppBuilderState of(BuildContext context) {
    return context.findAncestorStateOfType<_AppBuilderState>();
  }

  @override
  _AppBuilderState createState() => _AppBuilderState();
}

class _AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild() {
    setState(() {});
  }
}
