import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flash'),
    );
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
    );
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
                child: Icon(Icons.clear),
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
