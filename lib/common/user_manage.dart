class UserManager {
  static late final UserManager _instance = UserManager._internal();

  factory UserManager() => _instance;

  // 私有的命名构造函数
  UserManager._internal();

  //初始默认值
  CPUserModel _model = CPUserModel();

  ///是否登陆
  bool isLogin() {
    return _model.userId.isNotEmpty && _model.token.isNotEmpty;
  }

  //初始化数据
  void init(dynamic data) {
    _model = CPUserModel.fromJson(data);
  }

  /*
  * 登录
  * */
  void login(dynamic data) async {
    _model = CPUserModel.fromJson(data);
  }

  /*
  * 登出
  * */
  void logout() {
    _model = CPUserModel();
  }

  CPUserModel getUser() {
    return _model;
  }

  String getUserId() {
    return _model.userId;
  }

  String getToken() {
    return _model.token;
  }

  String getMobile() {
    return _model.mobile;
  }
}

class CPUserModel {
  CPUserModel({
    String? userId,
    String? token,
    String? mobile,
    String? account,
  }) {
    _userId = userId;
    _token = token;
    _mobile = mobile;
    _account = account;
  }

  CPUserModel.fromJson(dynamic json) {
    _userId = json['userId'];
    _token = json['token'];
    _mobile = json['mobile'];
    _account = json['account'];
  }

  String? _userId;
  String? _token;
  String? _mobile;
  String? _account;

  CPUserModel copyWith({
    String? userId,
    String? token,
    String? mobile,
    String? account,
  }) =>
      CPUserModel(
        userId: userId ?? _userId,
        token: token ?? _token,
        mobile: mobile ?? _mobile,
        account: account ?? _account,
      );

  String get userId => _userId ?? "";

  String get token => _token ?? "";

  String get mobile => _mobile ?? "";

  String get account => _account ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['token'] = _token;
    map['mobile'] = _mobile;
    map['account'] = _account;
    return map;
  }
}
