import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/loading_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
//加载中动画
showLoading({String status = "Loading.."}) {
  showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black12,
      useSafeArea: true,
      useRootNavigator: true,
      context: Get.context!,
      builder: (context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 100.w,
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              child: Container(
                height: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(5.w),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(height: 10.w),
                    Text(
                      status,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
