import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double designWidth = 360;
const double designHeight = 640;
const String assetIcon = "iconFont";
const String assetImage = "lib/asset/image/";
const String assetJson = "lib/asset/json/";
const Color primaryColor = Color(0xff000000);
const Color primaryBackground = Colors.white;
const Color primaryWhite = Colors.white;
const Color primaryBlack = Color(0xff12161F);
const Color primaryGrey = Color(0xffe1e1e1);
const Color primaryRed = Color(0xFFE53935);
const Color primaryCCC = Color(0xffCCCCCC);

const SystemUiOverlayStyle systemOverlayStyleLight = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarDividerColor: Colors.transparent,
);
const SystemUiOverlayStyle systemOverlayStyleDark = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.light,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarDividerColor: Colors.transparent,
);

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

/**=**********Share Preference Store************=*/
//用户信息
const String userKey = "userKey";

///**************************  登陆模块API  ***********************************
// 获取国家或地区
const apiGetRegion = "sto/rest/admin/api/v1/cloud/cfg?keys=nationalFlag";
//获取验证码
const apiSendSms = "cloudpick/rest/admin/api/v1/logon/sendsms";
//SMS登陆接口
const apiSMSLogin = "cloudpick/rest/admin/api/v1/logon/login";
//Account登陆接口
const apiAccountLogin = "cloudpick/rest/admin/api/v1/logon/account/login";
//修改登录密码
const apiPassword = "cloudpick/rest/admin/api/v1/logon/account/update/password";
//多渠道选择渠道后登陆
const apiMLogin = "cloudpick/rest/admin/api/v1/logon/mlogin";
//商店列表
const apiStoreList = "sto/rest/admin/api/v1/store/channel/auth/list";
//获取仓库列表
const apiStorageList = "cloudpick/rest/operator/api/v1/ware/warehouse/list";
//查询所有仓库
const apiAllStorageList = "cloudpick/rest/operator/api/v1/ware/warehouse/all";
//获取供应商
const apiSupplierList = "erp/rest/operator/api/v1/ware/supplier";
//通过Token获取用户信息
const apiGetuser = "cloudpick/rest/admin/api/v1/logon/getuser";
//获取所有的货币
const apiCurrency = "sto/rest/api/v1/currency";
//获取货架信息
const apiRackInfo = "sto/rest/admin/api/v1/rack/%s/info";
//获取栏位信息列表
const apiShelfList = "sto/rest/admin/api/v1/rack/%s/shelf/list";
//货架重力事件
const apiRackEvent = "sto/rest/admin/api/v1/wtevent/rack";
//重新计算货架商品数量
const apiRackGoodsNum = "sto/rest/operator/api/v1/store/%s/rack/%s/goodsNum";
//获取栏位重量接口
const apiRackWeight = "sto/rest/operator/api/v1/store/%s/rack/%s/weights";
//重量清零
const apiRackWeightZero = "/sto/rest/operator/api/v1/store/%s/rack/%s/weight/zero";
