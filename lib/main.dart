import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flash/admob_private.dart';
import 'package:flash/common/app_builder.dart';
import 'package:flash/common/appearance.dart';
import 'package:flash/common/configuration.dart';
import 'package:flash/common/material_colors.dart';
import 'package:flash/drawer/settings_drawer.dart';
import 'package:flash/main/main_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
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
          brightness: _configuration.appearance != AppearanceType.dark
              ? Brightness.light
              : Brightness.dark,
          primarySwatch: _configuration.colors.primaryColor,
          accentColor: _configuration.appearance != AppearanceType.dark
              ? null
              : _configuration.colors.accentColor,
        ),
        darkTheme: ThemeData(
          brightness: _configuration.appearance != AppearanceType.light
              ? Brightness.dark
              : Brightness.light,
          primarySwatch: _configuration.colors.primaryColor,
          accentColor: _configuration.appearance != AppearanceType.light
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
  bool _isFromSharingIntent = false;
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
          'images/app_icon.svg',
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
      drawer: SettingsDrawer(widget.title),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: mainArea,
            ),
            Visibility(
              visible: !_isFocusedOnMainArea,
              child: Container(
                height: 50,
                child: AdmobBanner(
                  adUnitId: AdMobPrivate.getAppId(),
                  adSize: AdmobBannerSize.BANNER,
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
    _setUpConfiguration();
    _setUpText();
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
        _setUpText();
        break;
      case AppLifecycleState.inactive:
        if (_isActive) {
          _isActive = false;
          _isFromSharingIntent = false;
          _saveText();
          ReceiveSharingIntent.reset();
        }
        break;
      default:
        break;
    }
  }

  void _setUpConfiguration() async {
    bool shouldRebuild = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int appearanceID = prefs.getInt('appearanceID');
    AppearanceType appearance = Appearance.convertToValue(appearanceID);
    _configuration.appearance = appearance;
    if (appearance != AppearanceType.system) {
      shouldRebuild = true;
    }

    int colorValue = prefs.getInt('colorValue');
    MaterialColors materialColors = MaterialColors.defaultColor;
    MaterialColors.all.forEach((colors) {
      if (colors.primaryColor.value == colorValue) {
        materialColors = colors;
      }
    });
    _configuration.colors = materialColors;
    if (materialColors != MaterialColors.defaultColor) {
      shouldRebuild = true;
    }

    if (shouldRebuild) {
      AppBuilder.of(context).rebuild();
    }
  }

  void _setUpText() async {
    ReceiveSharingIntent.getInitialText().then((value) {
      _isFromSharingIntent = true;
      _updateController(value);
    });
    ReceiveSharingIntent.getTextStream().first.then((value) {
      _isFromSharingIntent = true;
      _updateController(value);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastDateString = prefs.getString('lastDate');
    String lastText = '';
    if (lastDateString != null) {
      DateTime lastDate = DateTime.parse(lastDateString);
      if (DateTime.now()
          .isBefore(lastDate.add(Duration(minutes: _flashTime)))) {
        lastText = prefs.getString('lastText');
      }
    }
    if (!_isFromSharingIntent) {
      _updateController(lastText);
    }
  }

  void _updateController(String text) {
    _controller.text = text;
    _controller.selection =
        TextSelection.collapsed(offset: _controller.text.length);
  }

  void _setUpBrightness() async {
    bool isDark;
    if (_configuration.appearance == AppearanceType.system) {
      isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    } else {
      isDark = _configuration.appearance == AppearanceType.dark;
    }
    if (!isDark) {
      _iconColor = Theme.of(context).primaryIconTheme.color;
    } else {
      _iconColor = Theme.of(context).accentColor;
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
