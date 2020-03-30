import 'package:flash/common/app_builder.dart';
import 'package:flash/common/appearance.dart';
import 'package:flash/common/configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppearanceSelector extends StatefulWidget {
  @override
  _AppearanceSelectorState createState() => _AppearanceSelectorState();
}

class _AppearanceSelectorState extends State<AppearanceSelector> {
  final Configuration _configuration = Configuration.getInstance();
  List<_AppearanceIconButton> _iconButtons;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: _iconButtons,
    );
  }

  @override
  void initState() {
    super.initState();
    _iconButtons = [
      _AppearanceIconButton(
        AppearanceType.system,
        icon: Icon(Icons.smartphone),
        tooltip: 'System',
        onPressed: _onUpdate,
      ),
      _AppearanceIconButton(
        AppearanceType.light,
        icon: Icon(Icons.wb_sunny),
        tooltip: 'Light',
        onPressed: _onUpdate,
      ),
      _AppearanceIconButton(
        AppearanceType.dark,
        icon: Icon(Icons.brightness_2),
        tooltip: 'Dark',
        onPressed: _onUpdate,
      ),
    ];
  }

  void _onUpdate() {
    _iconButtons.forEach((iconButton) {
      if (_configuration.appearance == iconButton._appearance) {
        iconButton._state._onSelected();
      } else {
        iconButton._state._onUnselected();
      }
    });
  }
}

class _AppearanceIconButton extends StatefulWidget {
  _AppearanceIconButton(
    this._appearance, {
    @required this.icon,
    this.tooltip,
    this.onPressed,
  });

  final AppearanceType _appearance;
  final Icon icon;
  final String tooltip;
  final Function onPressed;
  final _AppearanceIconButtonState _state = _AppearanceIconButtonState();

  @override
  _AppearanceIconButtonState createState() => _state;
}

class _AppearanceIconButtonState extends State<_AppearanceIconButton> {
  final Configuration _configuration = Configuration.getInstance();
  Color _color;

  @override
  Widget build(BuildContext context) {
    if (_configuration.appearance == widget._appearance) {
      _color = Theme.of(context).accentColor;
    } else {
      _color = Theme.of(context).unselectedWidgetColor;
    }
    return IconButton(
      icon: widget.icon,
      color: _color,
      tooltip: widget.tooltip,
      onPressed: _changeAppearance,
    );
  }

  void _changeAppearance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'appearanceID', Appearance.convertToID(widget._appearance));
    _configuration.appearance = widget._appearance;
    widget.onPressed();
    AppBuilder.of(context).rebuild();
  }

  void _onSelected() {
    setState(() {
      _color = Theme.of(context).accentColor;
    });
  }

  void _onUnselected() {
    setState(() {
      _color = Theme.of(context).unselectedWidgetColor;
    });
  }
}
