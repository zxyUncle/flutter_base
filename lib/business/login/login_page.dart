import 'dart:ffi';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/const.dart';
import 'package:flutter_base/utils/app_bar_utils.dart';
import 'package:flutter_base/utils/easy_refresh_utils.dart';
import 'package:flutter_base/utils/toast_utils.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var _appVersion = '';

  @override
  void initState() {
    super.initState();
    getVersion().then((value) => {
          setState(() {
            _appVersion = 'V$value';
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: noAppBar(),
        body: easyRefreshSpringBack(child: _body()),
      ),
    );
  }

  _onLogin() async {
    showToast('登录');
  }

  _body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60.w),
          //图标
          Center(
            child: Image.asset(
              '${assetImage}login/ic_notication.png',
              width: 150.w,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: 30.w,
          ),
          //账号
          viewTextFild('login_account'.tr, TextInputType.number),
          SizedBox(
            height: 20.w,
          ),
          //密码
          viewTextFild('login_password'.tr, TextInputType.number),
          SizedBox(height: 20.w),
          //登录
          _viewLogin(),
          SizedBox(height: 50.w),
          Text(
            _appVersion,
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
          ),
        ],
      ),
    );
  }

  //输入框
  Widget viewTextFild(hintMessage, keyboardTypeValue) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
        color: primaryGrey,
      ),
      child: TextField(
        maxLength: 18,
        keyboardType: keyboardTypeValue,
        style: TextStyle(color: Colors.black, fontSize: 14.sp),
        decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            hintText: hintMessage,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp)),
      ),
    );
  }

  //登录
  Widget _viewLogin() {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: _onLogin,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 15.w),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: Text(
            '登录',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ));
  }
}
