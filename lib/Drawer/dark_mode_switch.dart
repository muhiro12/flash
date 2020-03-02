import 'package:flash/Common/app_builder.dart';
import 'package:flash/Common/configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeSwitch extends StatefulWidget {
  @override
  _DarkModeSwitchState createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  final Configuration _configuration = Configuration.getInstance();

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _configuration.isDark,
      activeColor: Theme.of(context).accentColor,
      onChanged: _changeBrightness,
    );
  }

  void _changeBrightness(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
    _configuration.isDark = isDark;
    AppBuilder.of(context).rebuild();
  }
}
