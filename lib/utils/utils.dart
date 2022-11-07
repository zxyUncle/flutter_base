import 'dart:developer';

import 'package:package_info_plus/package_info_plus.dart';

loggin(Object? object) {
  String message = "$object";
  log(message);
  print(object);
}

//获取版本号
Future<String> getVersion() async{
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
