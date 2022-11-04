import 'dart:convert';

import 'package:flutter/services.dart';

import '../common/app_config.dart';
import '../common/const.dart';
import '../utils/utils.dart';

/// type : ""
/// name : ""
/// url : ""
/// imageHost : ""
class ServerModel {
  ServerModel({
    String? type,
    String? name,
    String? url,
    String? imageHost,
  }) {
    _type = type;
    _name = name;
    _url = url;
    _imageHost = imageHost;
  }

  ServerModel.fromJson(dynamic json) {
    _type = json['type'];
    _name = json['name'];
    _url = json['url'];
    _imageHost = json['imageHost'];
  }

  String? _type;
  String? _name;
  String? _url;
  String? _imageHost;

  ServerModel copyWith({
    String? type,
    String? name,
    String? url,
    String? imageHost,
  }) =>
      ServerModel(
        type: type ?? _type,
        name: name ?? _name,
        url: url ?? _url,
        imageHost: imageHost ?? _imageHost,
      );

  //正式环境需要加载的
  //type 0测试环境  1正式环境  2自定义环境
  bool isRelease() {
    return type == "1";
  }

  String get type => _type ?? "";

  String get name => _name ?? "";

  String get url => _url ?? "";

  //默认的图片地址前缀
  String get imageHost => _imageHost ?? "http://img.yunatop.com";

  bool equals(ServerModel? model) {
    return model != null &&
        model.type.isNotEmpty &&
        model.type == type &&
        model.name.isNotEmpty &&
        model.name == name &&
        model.url.isNotEmpty &&
        model.url == url &&
        model.imageHost.isNotEmpty &&
        model.imageHost == imageHost;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['name'] = _name;
    map['url'] = _url;
    map['imageHost'] = _imageHost;
    return map;
  }
}

List<ServerModel> serverList = [];

loadServerList() async {
  if (serverList.isEmpty) {
    try {
      var value = await rootBundle.loadString("${assetJson}server.json");
      var arr = json.decode(value);
      for (var item in arr) {
        ServerModel serverModel = ServerModel.fromJson(item);
        if (AppConfig().isRelease) {
          if (serverModel.isRelease()) {
            serverList.add(serverModel);
          }
        } else {
          serverList.add(serverModel);
        }
      }
    } catch (e) {
      myPrint(e);
    }
  }
}
