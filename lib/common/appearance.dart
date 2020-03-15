class Appearance {
  static AppearanceType convertToValue(int value) {
    switch (value) {
      case 1:
        return AppearanceType.light;
      case 2:
        return AppearanceType.dark;
      default:
        return AppearanceType.system;
    }
  }

  static int convertToID(AppearanceType appearanceType) {
    switch (appearanceType) {
      case AppearanceType.light:
        return 1;
      case AppearanceType.dark:
        return 2;
      default:
        return 0;
    }
  }
}

enum AppearanceType {
  system,
  light,
  dark,
}
