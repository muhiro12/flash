import 'package:flutter/material.dart';

class MaterialColors {
  static List<_MaterialColorsPair> all = [
    MaterialColors.pink,
    MaterialColors.red,
    MaterialColors.deepOrange,
    MaterialColors.orange,
    MaterialColors.amber,
    MaterialColors.yellow,
    MaterialColors.lime,
    MaterialColors.lightGreen,
    MaterialColors.green,
    MaterialColors.teal,
    MaterialColors.cyan,
    MaterialColors.lightBlue,
    MaterialColors.blue,
    MaterialColors.indigo,
    MaterialColors.purple,
    MaterialColors.deepPurple,
    MaterialColors.blueGrey,
    MaterialColors.brown,
    MaterialColors.grey,
  ];

  static _MaterialColorsPair pink =
      _MaterialColorsPair(Colors.pink, Colors.pinkAccent);

  static _MaterialColorsPair red =
      _MaterialColorsPair(Colors.red, Colors.redAccent);

  static _MaterialColorsPair deepOrange =
      _MaterialColorsPair(Colors.deepOrange, Colors.deepOrangeAccent);

  static _MaterialColorsPair orange =
      _MaterialColorsPair(Colors.orange, Colors.orangeAccent);

  static _MaterialColorsPair amber =
      _MaterialColorsPair(Colors.amber, Colors.amberAccent);

  static _MaterialColorsPair yellow =
      _MaterialColorsPair(Colors.yellow, Colors.yellowAccent);

  static _MaterialColorsPair lime =
      _MaterialColorsPair(Colors.lime, Colors.limeAccent);

  static _MaterialColorsPair lightGreen =
      _MaterialColorsPair(Colors.lightGreen, Colors.lightGreenAccent);

  static _MaterialColorsPair green =
      _MaterialColorsPair(Colors.green, Colors.greenAccent);

  static _MaterialColorsPair teal =
      _MaterialColorsPair(Colors.teal, Colors.tealAccent);

  static _MaterialColorsPair cyan =
      _MaterialColorsPair(Colors.cyan, Colors.cyanAccent);

  static _MaterialColorsPair lightBlue =
      _MaterialColorsPair(Colors.lightBlue, Colors.lightBlueAccent);

  static _MaterialColorsPair blue =
      _MaterialColorsPair(Colors.blue, Colors.blueAccent);

  static _MaterialColorsPair indigo =
      _MaterialColorsPair(Colors.indigo, Colors.indigoAccent);

  static _MaterialColorsPair purple =
      _MaterialColorsPair(Colors.purple, Colors.purpleAccent);

  static _MaterialColorsPair deepPurple =
      _MaterialColorsPair(Colors.deepPurple, Colors.deepPurpleAccent);

  static _MaterialColorsPair blueGrey =
      _MaterialColorsPair(Colors.blueGrey, Colors.blueGrey);

  static _MaterialColorsPair brown =
      _MaterialColorsPair(Colors.brown, Colors.brown);

  static _MaterialColorsPair grey =
      _MaterialColorsPair(Colors.grey, Colors.grey);

  static _MaterialColorsPair convertFrom(Color color) {
    if (color == Colors.pink || color == Colors.pinkAccent) {
      return pink;
    } else if (color == Colors.red || color == Colors.redAccent) {
      return red;
    } else if (color == Colors.deepOrange || color == Colors.deepOrangeAccent) {
      return deepOrange;
    } else if (color == Colors.orange || color == Colors.orangeAccent) {
      return orange;
    } else if (color == Colors.amber || color == Colors.amberAccent) {
      return amber;
    } else if (color == Colors.yellow || color == Colors.yellowAccent) {
      return yellow;
    } else if (color == Colors.lime || color == Colors.limeAccent) {
      return lime;
    } else if (color == Colors.lightGreen || color == Colors.lightGreenAccent) {
      return lightGreen;
    } else if (color == Colors.green || color == Colors.greenAccent) {
      return green;
    } else if (color == Colors.teal || color == Colors.tealAccent) {
      return teal;
    } else if (color == Colors.cyan || color == Colors.cyanAccent) {
      return cyan;
    } else if (color == Colors.lightBlue || color == Colors.lightBlueAccent) {
      return lightBlue;
    } else if (color == Colors.blue || color == Colors.blueAccent) {
      return blue;
    } else if (color == Colors.indigo || color == Colors.indigoAccent) {
      return indigo;
    } else if (color == Colors.purple || color == Colors.purpleAccent) {
      return purple;
    } else if (color == Colors.deepPurple || color == Colors.deepPurpleAccent) {
      return deepPurple;
    } else if (color == Colors.blueGrey) {
      return blueGrey;
    } else if (color == Colors.brown) {
      return brown;
    } else if (color == Colors.grey) {
      return grey;
    }
    return blue;
  }
}

class _MaterialColorsPair {
  _MaterialColorsPair(this.primaryColor, this.accentColor);

  Color primaryColor;
  Color accentColor;
}
