library screens;

export 'package:flutter_playground/src/screens/app_navigator.dart'
    show AppNavigator;
export 'package:flutter_playground/src/screens/home/home_page.dart'
    show HomePage;

class NamedRoutes {
  NamedRoutes._internal();

  static const HOME = "HOME";
  static const FAVORITES = "FAVORITES";
  static const SEARCH_RESULT = "SEARCH_RESULT";
  static const DETAILS = "DETAILS";
}
