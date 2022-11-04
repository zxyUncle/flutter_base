
import 'package:shared_preferences/shared_preferences.dart';

///设置存储
class SPreUtils {
  ///存储值,字符串类型
  static void setString(String key, String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  ///获取值
  static Future<String> getString(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var value = sp.get(key) ?? "";
    return value.toString();
  }

  ///删除值
  static Future<bool> remove(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  ///存储值
  static void setStringList(String key, List<String> value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList(key, value);
  }

  ///获取值
  static Future<List<String>> getStringList(String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getStringList(key) ?? [];
  }

}
