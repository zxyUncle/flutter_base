import '../business/login/login_page.dart';

class Routers {
  static String login = "/login";

  static var list = {
    login: (context) => LoginPage(),
  };
}
