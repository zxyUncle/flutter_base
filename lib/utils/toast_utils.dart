import 'package:flutter_base/utils/loading_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

showToast(
  String? status, {
  Duration? duration,
  EasyLoadingToastPosition? toastPosition,
  EasyLoadingMaskType? maskType,
  bool? dismissOnTap,
}) {
  EasyLoading.showToast(
    status ?? "",
    duration: duration,
    toastPosition: toastPosition,
    maskType: maskType,
    dismissOnTap: dismissOnTap,
  );
}

showLoading({String status = "loading"}){
  EasyLoading.show(status: 'loading...');
}