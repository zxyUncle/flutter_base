import 'dart:io';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/server_model.dart';
import 'package:flutter_base/common/user_manage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http_proxy/http_proxy.dart';

import '../utils/dialog_utils.dart';
import '../utils/utils.dart';
import 'const.dart';
import 'http.dart';

class AppConfig {
  static late final AppConfig _instance = AppConfig._internal();

  factory AppConfig() => _instance;

  // 私有的命名构造函数
  AppConfig._internal();

  //app交互通道
  final MethodChannel _mainChannel =
      const MethodChannel("com.flutter.main.methodChannel");

  //是否是app进入
  bool isApp = false;

  //手动定义RELEASE ｜ DEBUG ,用于发布条件的判断
  bool isRelease = true;

  //网络地址
  String baseUrl = "";

  //渠道
  String channel = "";

  //本地语言
  String local = "";

  //图片名称前缀
  String imgHost = "http://img.yunatop.com/";

  //初始化数据
  initData(bool app) async {
    //初始化数据--start
    try {
      isApp = app;
      await getAppConfigData();
    } catch (error) {
      loggin(error);
    }
    //初始化加载框
    initEasyLoading();
    //initEasyRefresh
    initEasyRefresh();
    try {
      if (!isRelease) {
        HttpProxy httpProxy = await HttpProxy.createHttpProxy();
        HttpOverrides.global = httpProxy;
      }
    } catch (error) {
      loggin(error);
    }
    //初始化配置--end
  }

  //初始化加载框
  initEasyLoading() {
    try {
      // EasyLoading.instance
      //   ..displayDuration = const Duration(milliseconds: 2000)
      //   ..indicatorType = EasyLoadingIndicatorType.ring //样式
      //   ..loadingStyle = EasyLoadingStyle.custom
      //   ..indicatorSize = 30   //指示器大小
      //   ..radius = 10  //圆角
      //   ..backgroundColor = const Color(0x77000000)
      //   ..indicatorColor = const Color(0xffFFFFFF)
      //   ..textColor = const Color(0xffFFFFFF)
      //   ..boxShadow = []
      //   ..contentPadding = EdgeInsets.all(10.w)
      //   ..dismissOnTap = true;
    } catch (error) {
      loggin(error);
    }
  }

  //初始化刷新加载
  initEasyRefresh() {
    // EasyRefresh.defaultHeaderBuilder = () => CupertinoHeader();
    // EasyRefresh.defaultFooterBuilder = () => CupertinoFooter();
    EasyRefresh.defaultHeaderBuilder = () => ClassicHeader(
          showMessage: false,
          showText: true,
          dragText: 'Pull to refresh'.tr,
          armedText: 'Release ready'.tr,
          readyText: 'Refreshing...'.tr,
          processingText: 'Refreshing...'.tr,
          processedText: 'Succeeded'.tr,
          noMoreText: 'No more'.tr,
          failedText: 'Failed'.tr,
          messageText: 'Last updated at %T'.tr,
        );
    EasyRefresh.defaultFooterBuilder = () => ClassicFooter(
          showMessage: false,
          showText: true,
          dragText: 'Pull to load'.tr,
          armedText: 'Release ready'.tr,
          readyText: 'Loading...'.tr,
          processingText: 'Loading...'.tr,
          processedText: 'Succeeded'.tr,
          noMoreText: 'No more'.tr,
          failedText: 'Failed'.tr,
          messageText: 'Last updated at %T'.tr,
        );
  }

  /*
  * APP 需要动态传入的参数如下：
  * baseUrl：网络请求地址，用于网络请求
  * */
  getAppConfigData() async {
    try {
      Map data = await _mainChannel.invokeMethod("getAppConfigData");
      isRelease = data["isRelease"] ?? isRelease;
      setBaseUrl(data["baseUrl"] ?? baseUrl);
      setImageHost(data["imgHost"] ?? imgHost);
      channel = data["channel"] ?? channel;
      local = data["local"] != null ? getFlutterLocal(data["local"]) : local;
      UserManager().init({
        "userId": data["userId"] ?? "",
        "token": data["token"] ?? "",
        "mobile": data["mobile"] ?? "",
      });
      loggin("*************接收到app的参数*************");
      loggin(data);
    } on MissingPluginException catch (error) {
      if (isApp) {
        showToast(error.message);
      } else {
        loggin(error.message);
      }
    }
  }

  void setBaseUrl(dynamic value) {
    if (value != null) {
      String url;
      if (value is ServerModel) {
        url = value.url;
        setImageHost(value);
      } else {
        url = value.toString();
      }
      baseUrl = url.toString().endsWith("/") ? url.toString() : "$url/";
      channel = ""; //切换域名时,渠道置为null
      Http().setBaseUrl();
    }
  }

  void setImageHost(dynamic value) {
    if (value != null) {
      String url;
      if (value is ServerModel) {
        url = value.imageHost;
      } else {
        url = value.toString();
      }
      imgHost = url.toString().endsWith("/") ? url.toString() : "$url/";
    }
  }

  back() async {
    try {
      if (Platform.isIOS) {
        await _mainChannel.invokeMethod("back");
      } else {
        SystemNavigator.pop();
      }
    } on MissingPluginException catch (error) {
      if (isApp) {
        showToast(error.message);
      } else {
        loggin(error.message);
      }
    }
  }

  interactivePopDisabled(bool value) async {
    try {
      if (Platform.isIOS) {
        await _mainChannel.invokeMethod("interactivePopDisabled", value);
      }
    } on MissingPluginException catch (error) {
      if (isApp) {
        showToast(error.message);
      } else {
        loggin(error.message);
      }
    }
  }

  /*
  * 登录
  * */
  login(
    var loginType,
    var yuan,
    var store,
    var storage,
    var allStorage,
    var supplier,
  ) async {
    try {
      Map<String, dynamic> loginMap = {
        "baseUrl": baseUrl,
        "channel": channel,
        "imgHost": imgHost,
        "user": UserManager().getUser().toJson(),
        "loginType": loginType,
        "yuan": yuan,
        "store": store,
        "storage": storage,
        "allStorage": allStorage,
        "supplier": supplier,
      };
      await _mainChannel.invokeMethod("login", loginMap);
    } on MissingPluginException catch (error) {
      if (isApp) {
        showToast(error.message);
      } else {
        loggin(error.message);
      }
    }
  }

  /*
  * 账户权限不足（没有分配店铺或者权限不足等）
  * */
  examine() async {
    try {
      await _mainChannel.invokeMethod("examine");
    } on MissingPluginException catch (error) {
      if (isApp) {
        showToast(error.message);
      } else {
        loggin(error.message);
      }
    }
  }

  Locale getDeviceLocale() {
    if (local.isEmpty) {
      return Get.deviceLocale ?? const Locale("en");
    } else {
      return Locale(local);
    }
  }

  getFlutterLocal(String local) {
    if (local == "zh-Hans" || local == "CN") {
      return "zh";
    } else if (local == "EN") {
      return "en";
    } else if (local == "DE") {
      return "de";
    } else if (local == "FR") {
      return "fr";
    } else if (local == "JA") {
      return "ja";
    }
    return local;
  }

  getLang() {
    String lang = "EN";
    switch (local) {
      case "zh":
        lang = "CN";
        break;
      case "en":
        lang = "EN";
        break;
      case "de":
        lang = "DE";
        break;
      case "fr":
        lang = "FR";
        break;
      case "ja":
        lang = "JA";
        break;
      case "ko":
        lang = "KO";
        break;
    }
    return lang;
  }

  ThemeMode getDeviceThemeMode() {
    return ThemeMode.light;
  }

  ThemeData obtainThemeData(bool light) {
    if (light) {
      return ThemeData.light().copyWith(
        primaryColor: Colors.white,
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.white,
        canvasColor: Colors.grey[100],
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        bottomAppBarColor: Colors.white,
        cardColor: Colors.white,
        splashColor: Colors.white,
        highlightColor: Colors.transparent,
        toggleableActiveColor: primaryColor,
        dividerColor: primaryCCC,
        indicatorColor: primaryColor,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: systemOverlayStyleLight,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          elevation: 0.3,
          titleTextStyle: TextStyle(
            fontSize: 18.sp,
            color: primaryBlack,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(
            color: primaryBlack,
          ),
          actionsIconTheme: const IconThemeData(
            color: primaryBlack,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedItemColor: const Color(0xff666666),
          unselectedLabelStyle: TextStyle(fontSize: 12.sp),
          unselectedIconTheme: IconThemeData(
            color: const Color(0xff666666),
            size: 25.sp,
          ),
          selectedItemColor: primaryColor,
          selectedLabelStyle: TextStyle(fontSize: 13.sp),
          selectedIconTheme: IconThemeData(
            color: primaryColor,
            size: 25.sp,
          ),
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            color: primaryBlack,
            fontSize: 16.sp,
          ),
          subtitle2: TextStyle(
            color: const Color(0xffFFFFFF),
            fontSize: 16.sp,
          ),
          bodyText1: TextStyle(
            color: const Color(0xffFFFFFF),
            fontSize: 16.sp,
          ),
          bodyText2: TextStyle(
            color: primaryBlack,
            fontSize: 16.sp,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionColor: primaryColor.withAlpha(100),
          selectionHandleColor: primaryColor,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: primaryColor,
        ),
        iconTheme: const IconThemeData(
          color: primaryBlack,
        ),
        primaryIconTheme: const IconThemeData(
          color: primaryBlack,
        ),
        cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
          primaryColor: primaryBlack,
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(
            color: primaryBlack,
            fontSize: 18.sp,
          ),
          contentTextStyle: TextStyle(
            color: primaryBlack,
            fontSize: 16.sp,
          ),
        ),
        colorScheme: const ColorScheme(
          primary: Colors.white,
          primaryContainer: Colors.white,
          secondary: primaryColor,
          secondaryContainer: primaryColor,
          background: Colors.white,
          surface: Colors.white,
          brightness: Brightness.light,
          error: Color(0xffcf6679),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
        ),
      );
    } else {
      return ThemeData.dark().copyWith(
        primaryColor: Colors.grey[900],
        primaryColorLight: Colors.grey[900],
        primaryColorDark: Colors.grey[900],
        canvasColor: Colors.grey[850],
        scaffoldBackgroundColor: Colors.grey[900],
        backgroundColor: Colors.grey[900],
        bottomAppBarColor: Colors.grey[900],
        cardColor: Colors.grey[900],
        highlightColor: Colors.transparent,
        toggleableActiveColor: primaryColor,
        dividerColor: const Color(0xff666666),
        splashColor: Colors.grey[900],
        indicatorColor: primaryColor,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: systemOverlayStyleDark,
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.3,
          titleTextStyle: TextStyle(
            fontSize: 18.sp,
            color: const Color(0xffAAAAAA),
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(
            color: Color(0xffAAAAAA),
          ),
          actionsIconTheme: const IconThemeData(
            color: Color(0xffAAAAAA),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900],
          unselectedItemColor: const Color(0xffAAAAAA),
          unselectedLabelStyle: TextStyle(fontSize: 12.sp),
          unselectedIconTheme: IconThemeData(
            color: const Color(0xffAAAAAA),
            size: 25.sp,
          ),
          selectedItemColor: primaryColor,
          selectedLabelStyle: TextStyle(fontSize: 13.sp),
          selectedIconTheme: IconThemeData(
            color: primaryColor,
            size: 25.sp,
          ),
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            color: const Color(0xffAAAAAA),
            fontSize: 16.sp,
          ),
          subtitle2: TextStyle(
            color: const Color(0xffAAAAAA),
            fontSize: 16.sp,
          ),
          bodyText1: TextStyle(
            color: const Color(0xffFFFFFF),
            fontSize: 16.sp,
          ),
          bodyText2: TextStyle(
            color: const Color(0xffAAAAAA),
            fontSize: 16.sp,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionColor: primaryColor.withAlpha(100),
          selectionHandleColor: primaryColor,
        ),
        buttonTheme: const ButtonThemeData(buttonColor: primaryColor),
        iconTheme: const IconThemeData(
          color: Color(0xffAAAAAA),
        ),
        primaryIconTheme: const IconThemeData(
          color: Color(0xffAAAAAA),
        ),
        cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
          primaryColor: Color(0xffAAAAAA),
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(
            color: const Color(0xffAAAAAA),
            fontSize: 18.sp,
          ),
          contentTextStyle: TextStyle(
            color: const Color(0xffAAAAAA),
            fontSize: 16.sp,
          ),
        ),
        colorScheme: ColorScheme(
          primary: Colors.grey[900] ?? const Color(0xFF212121),
          primaryContainer: Colors.grey[900] ?? const Color(0xFF212121),
          secondary: primaryColor,
          secondaryContainer: primaryColor,
          background: Colors.grey[900] ?? const Color(0xFF212121),
          surface: Colors.grey[900] ?? const Color(0xFF212121),
          brightness: Brightness.dark,
          error: const Color(0xffcf6679),
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.black,
        ),
      );
    }
  }
}
