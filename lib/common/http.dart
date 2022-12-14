import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../utils/dialog_utils.dart';
import '../utils/utils.dart';
import 'app_config.dart';
import 'router.dart';
import 'user_manage.dart';

class Http {
  static final Http _instance = Http._internal();

  factory Http() => _instance;

  late Dio _dio;

  Http._internal() {
    _init();
  }

  void _init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig().baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 30000,
      ),
    );
    if (_dio.httpClientAdapter is DefaultHttpClientAdapter) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) {
          return true;
        };
      };
    }
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers = {
            "lang": AppConfig().getLang(),
          };
          if (UserManager().isLogin()) {
            options.headers["token"] = UserManager().getToken();
          }
          if (AppConfig().channel.isNotEmpty) {
            options.headers["channel"] = AppConfig().channel;
            options.queryParameters["channel"] = AppConfig().channel;
            if (options.data is Map) {
              options.data["channel"] = AppConfig().channel;
            }
          }
          return handler.next(options);
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (message) {
          loggin(message);
        },
      ),
    );
  }

  void setBaseUrl() {
    _dio.options.baseUrl = AppConfig().baseUrl;
  }

  void close({bool force = true}) {
    _dio.close(force: force);
    _init();
  }

  Future<BaseResult> get(
    String path, {
    bool? raw,
    bool? loading,
    Map<String, dynamic>? queryParameters,
    Function(BaseResult)? success,
    Function(BaseResult)? error,
  }) async {
    return _request(
      path,
      "get",
      raw: raw,
      loading: loading,
      queryParameters: queryParameters,
      success: success,
      error: error,
    );
  }

  Future<BaseResult> post(
    String path, {
    bool? raw,
    bool? loading,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Function(BaseResult)? success,
    Function(BaseResult)? error,
  }) async {
    return _request(
      path,
      "post",
      raw: raw,
      loading: loading,
      body: body,
      queryParameters: queryParameters,
      success: success,
      error: error,
    );
  }

  Future<BaseResult> _request(
    String path,
    String method, {
    bool? raw,
    bool? loading,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Function(BaseResult)? success,
    Function(BaseResult)? error,
  }) async {
    BaseResult result;
    try {
      if (loading ?? false) {
        showLoading();
      }
      Response? response;
      if (method == "get") {
        response = await _dio.get(
          path,
          queryParameters: queryParameters,
        );
      } else if (method == "post") {
        response = await _dio.post(
          path,
          data: body ?? {},
          queryParameters: queryParameters,
        );
      }
      if (response != null) {
        result = handleResponse(response, raw);
      } else {
        result = BaseResult(
          apiMethodError,
          "????????????????????????",
        );
      }
      if (loading ?? false) {
        dismissDialog();
      }
    } on DioError catch (error) {
      if (loading ?? false) {
        dismissDialog();
      }
      if (error.response != null && error.response?.data != null) {
        result = handleResponse(error.response!, raw);
      } else {
        if (error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.sendTimeout ||
            error.type == DioErrorType.receiveTimeout) {
          result = BaseResult(apiTimeoutError, "network_timeout".tr);
        } else {
          result = BaseResult(apiUnknownError, "network_error".tr);
        }
        loggin(error);
      }
    } catch (e) {
      if (loading ?? false) {
        dismissDialog();
      }
      result = BaseResult(apiUnknownError, e.toString());
      loggin(e);
    }
    try {
      if (result.success()) {
        success!(result);
      } else if (error != null) {
        error(result);
      } else if (result.tokenError()) {
        UserManager().logout();
        Get.offAllNamed(Routers.login);
      } else {
        showToast(result.message);
      }
    } catch (e) {
      loggin(e);
    }
    return result;
  }

  BaseResult handleResponse(Response response, bool? raw) {
    BaseResult result;
    if (response.data != null) {
      result = BaseResult.fromJson(response.data);
      if (raw ?? false) {
        result.data = response.data;
      }
    } else {
      result = BaseResult(
        response.statusCode == 200 ? apiSuccess : response.statusCode,
        response.statusMessage,
      );
    }
    return result;
  }
}

class BaseResult {
  dynamic code;
  dynamic message;
  dynamic data;

  BaseResult(this.code, this.message);

  BaseResult.fromJson(dynamic json) {
    try {
      if (json is Map) {
        code = json["code"];
        message = json["message"];
        data = json["data"];
      } else {
        code = apiResponseError;
        message = json.toString();
      }
    } catch (e) {
      loggin(e);
    }
  }

  bool success() {
    return code == apiSuccess;
  }

  bool tokenError() {
    return code == apiTokenError;
  }
}

///???????????????????????????
const apiMethodError = -100;

///????????????
const apiTimeoutError = -200;

///????????????????????????
const apiResponseError = -300;

///????????????????????????
const apiUnknownError = -1000;

//??????????????????
const apiSuccess = "0000";

//Token ??????/?????????/????????????
const apiTokenError = "LGN4001000";
