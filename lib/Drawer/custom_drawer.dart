import 'package:flash/Drawer/color_theme_grid_view.dart';
import 'package:flash/Drawer/dark_mode_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Header',
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          ListTile(
            leading: Text('Dark Mode'),
            title: Align(
              alignment: Alignment.centerLeft,
              child: DarkModeSwitch(),
            ),
          ),
          ListTile(
            leading: Text('Theme'),
            title: ColorThemeGridView(),
          ),
        ],
      ),
    );
  }
}
