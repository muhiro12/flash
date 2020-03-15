import 'package:flash/Common/app_builder.dart';
import 'package:flash/Common/appearance.dart';
import 'package:flash/Common/configuration.dart';
import 'package:flash/Common/material_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorThemeSelector extends StatefulWidget {
  @override
  _ColorThemeSelectorState createState() => _ColorThemeSelectorState();
}

class _ColorThemeSelectorState extends State<ColorThemeSelector> {
  final Configuration _configuration = Configuration.getInstance();

  @override
  Widget build(BuildContext context) {
    double floatingActionButtonHeight = 56;
    double spacing = 5;
    return Container(
      height: floatingActionButtonHeight * 2 + 5,
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.horizontal,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        padding: EdgeInsets.all(spacing),
        children: MaterialColors.all
            .map((materialColor) =>
                _configuration.appearance == AppearanceType.dark
                    ? _ColorFloatingActionButton(materialColor.primaryColor)
                    : _ColorFloatingActionButton(materialColor.accentColor))
            .toList(),
      ),
    );
  }
}

class _ColorFloatingActionButton extends StatefulWidget {
  _ColorFloatingActionButton(this._color);

  final Color _color;

  @override
  _ColorFloatingActionButtonState createState() =>
      _ColorFloatingActionButtonState();
}

class _ColorFloatingActionButtonState
    extends State<_ColorFloatingActionButton> {
  final Configuration _configuration = Configuration.getInstance();

  @override
  Widget build(BuildContext context) {
    Icon icon;
    if (_configuration.colors == MaterialColors.convertFrom(widget._color)) {
      icon = Icon(Icons.check);
    }
    return FloatingActionButton(
      backgroundColor: widget._color,
      elevation: 3,
      onPressed: _changeColorTheme,
      child: icon,
    );
  }

  void _changeColorTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('colorValue', widget._color.value);
    _configuration.colors = MaterialColors.convertFrom(widget._color);
    AppBuilder.of(context).rebuild();
  }
}
