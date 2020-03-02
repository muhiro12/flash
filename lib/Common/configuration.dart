import 'package:flash/Common/material_colors.dart';

class Configuration {
  Configuration._();

  static Configuration _instance = Configuration._();

  bool isDark;
  MaterialColors colors = MaterialColors.blue;

  static Configuration getInstance() {
    return _instance;
  }
}
