import 'package:flash/Common/appearance.dart';
import 'package:flash/Common/material_colors.dart';

class Configuration {
  Configuration._();

  static Configuration _instance = Configuration._();

  AppearanceType appearance = AppearanceType.system;
  MaterialColors colors = MaterialColors.defaultColor;

  static Configuration getInstance() {
    return _instance;
  }
}
