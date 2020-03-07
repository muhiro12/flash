import 'package:flash/Drawer/appearance_selector.dart';
import 'package:flash/Drawer/color_theme_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsDrawer extends StatelessWidget {
  SettingsDrawer(this._title);

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
            leading: Text('Appearance'),
            title: Align(
              alignment: Alignment.centerLeft,
              child: AppearanceSelector(),
            ),
          ),
          ListTile(
            leading: Text('Theme'),
            title: ColorThemeSelector(),
          ),
          AboutListTile(
            applicationVersion: '1.0.0',
            applicationIcon: SvgPicture.asset(
              'assets/images/launcher.svg',
              width: 50,
            ),
            aboutBoxChildren: <Widget>[
              Text('Thenk you for using!!'),
            ],
            child: Text('About'),
          ),
        ],
      ),
    );
  }
}
