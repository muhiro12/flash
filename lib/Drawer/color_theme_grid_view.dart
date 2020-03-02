import 'package:flash/Common/app_builder.dart';
import 'package:flash/Common/configuration.dart';
import 'package:flash/Common/material_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorThemeGridView extends StatefulWidget {
  @override
  _ColorThemeGridViewState createState() => _ColorThemeGridViewState();
}

class _ColorThemeGridViewState extends State<ColorThemeGridView> {
  final Configuration _configuration = Configuration.getInstance();

  @override
  Widget build(BuildContext context) {
    double spacing = 5;
    return Container(
      height: 120,
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.horizontal,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        padding: EdgeInsets.all(spacing),
        children: MaterialColors.all
            .map((materialColor) => _configuration.isDark
                ? _colorChip(materialColor.primaryColor)
                : _colorChip(materialColor.accentColor))
            .toList(),
      ),
    );
  }

  Widget _colorChip(
    Color color,
  ) {
    Icon icon;
    if (_configuration.colors == MaterialColors.convertFrom(color)) {
      icon = Icon(Icons.check);
    }
    return FloatingActionButton(
        backgroundColor: color,
        elevation: 3,
        onPressed: () => _changeTheme(color),
        child: icon);
  }

  void _changeTheme(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('colorValue', color.value);
    final colors = MaterialColors.convertFrom(color);
    _configuration.colors = colors;
    AppBuilder.of(context).rebuild();
  }
}
