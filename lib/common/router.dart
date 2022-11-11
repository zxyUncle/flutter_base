import 'package:flutter_base/widget/my_tabbar.dart';

import '../business/login/login_page.dart';

class Routers {
  static String login = "/login";
  static String tabBar = "/tabbar";

  static String homePage = "/homePage";
  static String orderPage = "/orderPage";
  static String minePage = "/minePage";

  static final list = {
    login: (context) => const LoginPage(),
    tabBar: (context) => MyTabbar(),
  };
}
