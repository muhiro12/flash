import 'package:flash/Drawer/appearance_selector.dart';
import 'package:flash/Drawer/color_theme_selector.dart';
import 'package:flash/Drawer/icon_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';

class SettingsDrawer extends StatefulWidget {
  SettingsDrawer(this._title);

  final String _title;

  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  String _name;
  String _version;

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
                  'images/launcher.svg',
                  alignment: Alignment.centerRight,
                ),
                Text(
                  widget._title,
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
          ListTile(
            title: Text('Help'),
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Icon Description'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('CLOSE'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                  content: IconDescription(),
                );
              },
            ),
          ),
          AboutListTile(
            applicationName: _name,
            applicationVersion: _version,
            applicationIcon: SvgPicture.asset(
              'images/launcher.svg',
              width: 50,
            ),
            aboutBoxChildren: <Widget>[
              Text('Thenk you for using Flash!!'),
            ],
            child: Text('About'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _setUpPackageInfo();
  }

  void _setUpPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _name = packageInfo.appName;
      _version = packageInfo.version;
    });
  }
}
