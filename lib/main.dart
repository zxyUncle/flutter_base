import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/router.dart';
import 'package:flutter_base/translation/translation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common/app_config.dart';
import 'common/const.dart';
import 'common/default_404.dart';

void main() {
  initConfig();
  initView();
  runApp(MyApp(
    routerName: Routers.login,
  ));
}

void initConfig() {
  AppConfig().baseUrl = "http://10.10.12.133:888";
  AppConfig().local = "zh";
  AppConfig().channel = "yunna";
  AppConfig().initData(false);
}

void initView(){
  EasyRefresh.defaultHeaderBuilder = () => ClassicHeader(
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

class MyApp extends StatefulWidget {
  String? routerName;

  MyApp({Key? key, this.routerName}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    initView();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(designWidth, designHeight),
      builder: (BuildContext context, Widget? child) {
        var translation = Translation();
        return GetMaterialApp(
            theme: AppConfig().obtainThemeData(true),
            darkTheme: AppConfig().obtainThemeData(false),
            themeMode: AppConfig().getDeviceThemeMode(),
            localizationsDelegates: const [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales:
                translation.keys.keys.map((e) => Locale(e)).toList(),
            translations: translation,
            locale: AppConfig().getDeviceLocale(),
            fallbackLocale: Locale(translation.keys.keys.first),
            routes: Routers.list,
            initialRoute: widget.routerName,
            unknownRoute:
                GetPage(name: '/notFound', page: () => const Default404()),
            navigatorObservers: [routeObserver],
            builder: EasyLoading.init(),
        );
      },
    );
  }
}
