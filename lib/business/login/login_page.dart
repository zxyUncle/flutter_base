import 'dart:ffi';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/const.dart';
import 'package:flutter_base/utils/app_bar_utils.dart';
import 'package:flutter_base/utils/easy_refresh_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: noAppBar(),
          body: easyRefreshSpringBack(
            child: _body(),
          )),
    );
  }

  _body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              '${assetImage}login/ic_notication.png',
              width: 100.w,
              fit: BoxFit.fitHeight,
            ),
          )
        ],
      ),
    );
  }
}
