import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/const.dart';

//正常的有返回按钮的toolbar，有状态栏
PreferredSizeWidget normalAppBar({String? title, Function? callback}) {
  return AppBar(
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (callback == null && Get.context != null) {
          Navigator.of(Get.context!).pop();
        } else {
          callback?.call();
        }
      },
    ),
    title: Text(title ?? "", textAlign: TextAlign.center),
  );
}

//无toolbar，有状态栏
PreferredSizeWidget noAppBar({Color? backgroundColor}) {
  return AppBar(
      toolbarHeight: 0, backgroundColor: backgroundColor ?? primaryColor);
}
