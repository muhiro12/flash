import 'package:flash/app_builder.dart';
import 'package:flash/material_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static bool _isDark;
  static Color _primaryColor = Colors.blue;
  static Color _accentColor = Colors.blueAccent;

  void fetchIsDark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp._isDark = prefs.getBool('isDark');
  }

  @override
  Widget build(BuildContext context) {
    fetchIsDark();
    return AppBuilder(builder: (context) {
      return MaterialApp(
        title: 'Flash',
        theme: ThemeData(
          brightness: _isDark != true ? Brightness.light : Brightness.dark,
          primarySwatch: _primaryColor,
          accentColor: _accentColor,
        ),
        darkTheme: ThemeData(
          brightness: _isDark != false ? Brightness.dark : Brightness.light,
          primarySwatch: _primaryColor,
          accentColor: _accentColor,
        ),
        home: MyHomePage(title: 'Flash'),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchFromPreferences();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('DebugLog $_isActive');
    switch (state) {
      case AppLifecycleState.resumed:
        _isActive = true;
        fetchFromPreferences();
        break;
      case AppLifecycleState.inactive:
        if (_isActive) {
          _isActive = false;
          saveToPreferences();
        }
        break;
      default:
        break;
    }
  }

  void fetchFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String lastDateString = prefs.getString('lastDate');
    if (lastDateString == null) {
      return;
    }

    DateTime lastDate = DateTime.parse(lastDateString);
    if (DateTime.now().isBefore(lastDate.add(Duration(minutes: _flashTime)))) {
      _controller.text = prefs.getString('lastText');
    } else {
      _controller.text = '';
    }
  }

  void saveToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lastText', _controller.text);
    prefs.setString('lastDate', DateTime.now().toString());
  }

  TextEditingController _controller = TextEditingController();
  int _flashTime = 5;
  double _margin = 10;
  bool _isActive = true;

  Widget _counter(
    BuildContext context, {
    int currentLength,
    int maxLength,
    bool isFocused,
  }) {
    return Text(
      '$currentLength characters',
      textAlign: TextAlign.end,
      style: TextStyle(color: Theme.of(context).accentColor),
    );
  }

  Widget _drawerTileTheme() {
    double spacing = 5;
    return ListTile(
      leading: Text('Theme'),
      title: Container(
        height: 120,
        child: GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.horizontal,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          padding: EdgeInsets.all(spacing),
          children: MaterialColors.all
              .map((materialColor) => MyApp._isDark
                  ? _colorChip(materialColor.primaryColor)
                  : _colorChip(materialColor.accentColor))
              .toList(),
        ),
      ),
    );
  }

  Widget _colorChip(
    Color color,
  ) {
    Icon icon;
    if (MyApp._primaryColor == MaterialColors.convertFrom(color).primaryColor) {
      icon = Icon(Icons.check);
    }
    return FloatingActionButton(
        backgroundColor: color,
        elevation: 3,
        onPressed: () => _changeTheme(color),
        child: icon);
  }

  void _changeBrightness(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
    MyApp._isDark = isDark;
    AppBuilder.of(context).rebuild();
  }

  void _changeTheme(Color color) {
    final materialColor = MaterialColors.convertFrom(color);
    MyApp._primaryColor = materialColor.primaryColor;
    MyApp._accentColor = materialColor.accentColor;
    AppBuilder.of(context).rebuild();
  }

  void _clear() {
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MyApp._isDark == null) {
      final isDark =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      _changeBrightness(isDark);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      endDrawer: Drawer(
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
                child: Switch(
                  value: MyApp._isDark,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: _changeBrightness,
                ),
              ),
            ),
            _drawerTileTheme()
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Card(
                margin: EdgeInsets.all(_margin),
                child: Container(
                  margin: EdgeInsets.all(_margin),
                  child: TextField(
                    controller: _controller,
                    buildCounter: _counter,
                    toolbarOptions: ToolbarOptions(
                      copy: true,
                      cut: true,
                      paste: true,
                      selectAll: true,
                    ),
                    expands: true,
                    maxLines: null,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: _margin, bottom: _margin),
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: _clear,
                tooltip: 'Clear',
                child: Icon(Icons.delete_outline),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
