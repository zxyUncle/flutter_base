import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../common/const.dart';

//正常的有返回按钮的toolbar，有状态栏
///[action]List类型，即可任意设计样式，表示右侧actions区域，可放置多个widget，通常为icon，如搜索icon、菜单icon
///[bottom]PreferredSizeWidget类型，appbar底部区域，通常为Tab控件，样式如下所示“首页”、“新闻”、“个人”的Tab
///[systemOverlayStyle]Brightness类型，表示当前appbar主题是亮或暗色调，有dark和light两个值，可影响系统状态栏的图标颜色，如下图所示，设为light后状态栏为黑色。设为dark后状态栏颜色为白色
PreferredSizeWidget normalAppBar(
    {String? title,
    List<Widget>? action,
    PreferredSizeWidget? bottom,
    SystemUiOverlayStyle? systemOverlayStyle,
    Function? callback}) {
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
    actions: action,
    bottom: bottom,
    systemOverlayStyle: systemOverlayStyle,
  );
}

//无toolbar，有状态栏
///[backgroundColor] 状态栏背景色
///[systemOverlayStyle] 状态栏图标颜色
PreferredSizeWidget noAppBar(
    {Color? backgroundColor = Colors.transparent,
    SystemUiOverlayStyle systemOverlayStyle = SystemUiOverlayStyle.light}) {
  return AppBar(
      toolbarHeight: 0,
      backgroundColor: backgroundColor,
      systemOverlayStyle: systemOverlayStyle,
      elevation: 0);
}

//取消蒙层
cancelMantle() {
  if (Platform.isAndroid) {
// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
