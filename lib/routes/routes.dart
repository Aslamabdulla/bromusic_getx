import 'package:bromusic/view/screens/home_page/home_page.dart';
import 'package:bromusic/view/screens/splash_screen/splash_screen.dart';

import 'package:get/get.dart';

class RoutesClass {
  static String splash = "/";
  static String home = "/";

  static String getNavRoute() => home;
  static String getSplashRoute() => splash;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: home, page: () => Homepage(name: 'GUEST')),
  ];
}
