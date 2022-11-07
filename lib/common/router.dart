import '../business/login/login_page.dart';

class Routers {
  static String login = "/login";

  static final list = {
    login: (context) => const LoginPage(),
  };
}
