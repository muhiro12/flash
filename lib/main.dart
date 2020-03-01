import 'package:flash/app_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static Color _primaryColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return MaterialApp(
        title: 'Flash',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: _primaryColor,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: _primaryColor,
          accentColor: _primaryColor,
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

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  double _margin = 10;

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
          children: <Widget>[
            _colorChip(Colors.pink),
            _colorChip(Colors.red),
            _colorChip(Colors.deepOrange),
            _colorChip(Colors.orange),
            _colorChip(Colors.amber),
            _colorChip(Colors.yellow),
            _colorChip(Colors.lime),
            _colorChip(Colors.lightGreen),
            _colorChip(Colors.green),
            _colorChip(Colors.teal),
            _colorChip(Colors.cyan),
            _colorChip(Colors.lightBlue),
            _colorChip(Colors.blue),
            _colorChip(Colors.indigo),
            _colorChip(Colors.purple),
            _colorChip(Colors.deepPurple),
            _colorChip(Colors.blueGrey),
            _colorChip(Colors.brown),
            _colorChip(Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _colorChip(
    Color color,
  ) {
    return FloatingActionButton(
      backgroundColor: color,
      elevation: 3,
      onPressed: () => _changeTheme(color),
      child: MyApp._primaryColor == color ? Icon(Icons.check) : null,
    );
  }

  void _changeTheme(Color color) {
    MyApp._primaryColor = color;
    AppBuilder.of(context).rebuild();
  }

  void _clear() {
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Theme.of(context).primaryColor,
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
            )
          ],
        ),
      ),
    );
  }
}
