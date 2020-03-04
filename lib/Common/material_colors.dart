import 'package:flutter/material.dart';

class MaterialColors {
  MaterialColors._(this.primaryColor, this.accentColor);

  Color primaryColor;
  Color accentColor;

  static List<MaterialColors> all = [
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

  static MaterialColors pink = MaterialColors._(Colors.pink, Colors.pinkAccent);

  static MaterialColors red = MaterialColors._(Colors.red, Colors.redAccent);

  static MaterialColors deepOrange =
      MaterialColors._(Colors.deepOrange, Colors.deepOrangeAccent);

  static MaterialColors orange =
      MaterialColors._(Colors.orange, Colors.orangeAccent);

  static MaterialColors amber =
      MaterialColors._(Colors.amber, Colors.amberAccent);

  static MaterialColors yellow =
      MaterialColors._(Colors.yellow, Colors.yellowAccent);

  static MaterialColors lime = MaterialColors._(Colors.lime, Colors.limeAccent);

  static MaterialColors lightGreen =
      MaterialColors._(Colors.lightGreen, Colors.lightGreenAccent);

  static MaterialColors green =
      MaterialColors._(Colors.green, Colors.greenAccent);

  static MaterialColors teal = MaterialColors._(Colors.teal, Colors.tealAccent);

  static MaterialColors cyan = MaterialColors._(Colors.cyan, Colors.cyanAccent);

  static MaterialColors lightBlue =
      MaterialColors._(Colors.lightBlue, Colors.lightBlueAccent);

  static MaterialColors blue = MaterialColors._(Colors.blue, Colors.blueAccent);

  static MaterialColors indigo =
      MaterialColors._(Colors.indigo, Colors.indigoAccent);

  static MaterialColors purple =
      MaterialColors._(Colors.purple, Colors.purpleAccent);

  static MaterialColors deepPurple =
      MaterialColors._(Colors.deepPurple, Colors.deepPurpleAccent);

  static MaterialColors blueGrey =
      MaterialColors._(Colors.blueGrey, Colors.blueGrey);

  static MaterialColors brown = MaterialColors._(Colors.brown, Colors.brown);

  static MaterialColors grey = MaterialColors._(Colors.grey, Colors.grey);

  static MaterialColors convertFrom(Color color) {
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
    return cyan;
  }
}
