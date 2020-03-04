import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flash/Common/app_builder.dart';
import 'package:flash/Common/configuration.dart';
import 'package:flash/Common/material_colors.dart';
import 'package:flash/Drawer/custom_drawer.dart';
import 'package:flash/Main/main_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Configuration _configuration = Configuration.getInstance();
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return MaterialApp(
        title: 'Flash',
        theme: ThemeData(
          brightness: _configuration.isDark != true
              ? Brightness.light
              : Brightness.dark,
          primarySwatch: _configuration.colors.primaryColor,
          accentColor: _configuration.isDark != true
              ? null
              : _configuration.colors.accentColor,
        ),
        darkTheme: ThemeData(
          brightness: _configuration.isDark != false
              ? Brightness.dark
              : Brightness.light,
          primarySwatch: _configuration.colors.primaryColor,
          accentColor: _configuration.isDark != false
              ? _configuration.colors.accentColor
              : null,
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
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final int _flashTime = 5;
  final Configuration _configuration = Configuration.getInstance();
  Color _iconColor = Colors.transparent;
  bool _isActive = true;
  bool _isFocusedOnMainArea = false;

  @override
  Widget build(BuildContext context) {
    _setUpBrightness();
    MainArea mainArea = MainArea(_controller, _focusNode);
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/images/app_icon.svg',
          height: AppBar().preferredSize.height * 0.8,
          color: _iconColor,
        ),
        actions: <Widget>[
          Visibility(
            visible: _isFocusedOnMainArea,
            child: FlatButton(
              child: Text(
                'Complete',
                style: TextStyle(
                  color: Theme.of(context).buttonColor,
                ),
              ),
              onPressed: _focusNode.unfocus,
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(widget.title),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: mainArea,
            ),
            Visibility(
              visible: false,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
    WidgetsBinding.instance.addObserver(this);
    _fetchConfiguration();
    _fetchText();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _isActive = true;
        _fetchText();
        break;
      case AppLifecycleState.inactive:
        if (_isActive) {
          _isActive = false;
          _saveText();
        }
        break;
      default:
        break;
    }
  }

  void _setUpBrightness() async {
    bool isDark = _configuration.isDark;
    if (isDark == null) {
      isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDark', isDark);
    }
    if (!isDark) {
      _iconColor = Theme.of(context).primaryIconTheme.color;
    } else {
      _iconColor = _configuration.colors.accentColor;
    }
  }

  void _fetchConfiguration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isDark = prefs.getBool('isDark');
    _configuration.isDark = isDark;

    int colorValue = prefs.getInt('colorValue');
    MaterialColors.all.forEach((colors) {
      if (colors.primaryColor.value == colorValue) {
        _configuration.colors = colors;
      }
    });

    AppBuilder.of(context).rebuild();
  }

  void _fetchText() async {
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

  void _saveText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastText', _controller.text);
    await prefs.setString('lastDate', DateTime.now().toString());
  }

  void _onFocusChanged() {
    setState(() {
      _isFocusedOnMainArea = _focusNode.hasFocus;
    });
  }
}
