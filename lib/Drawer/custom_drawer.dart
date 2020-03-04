import 'package:flash/Drawer/color_theme_grid_view.dart';
import 'package:flash/Drawer/dark_mode_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer(this._title);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/launcher.svg',
                  alignment: Alignment.centerRight,
                ),
                Text(
                  _title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
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
