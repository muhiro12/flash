import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: ListView(
        children: <Widget>[
          Container(
            height: 10,
          ),
          Text('Content'),
          Divider(),
          ListTile(
            leading: Icon(Icons.content_copy),
            title: Text('Copy'),
          ),
          ListTile(
            leading: Icon(Icons.content_paste),
            title: Text('Paste'),
          ),
          ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text('Delete'),
          ),
          Container(
            height: 10,
          ),
          Text('Appearance (Dark Mode)'),
          Divider(),
          ListTile(
            leading: Icon(Icons.smartphone),
            title: Text('System Default'),
          ),
          ListTile(
            leading: Icon(Icons.wb_sunny),
            title: Text('Light'),
          ),
          ListTile(
            leading: Icon(Icons.brightness_2),
            title: Text('Dark'),
          ),
          Container(
            height: 10,
          ),
          Text('Other'),
          Divider(),
          ListTile(
            leading: Icon(Icons.keyboard_hide),
            title: Text('Hide keyboard'),
          ),
        ],
      ),
    );
  }
}
