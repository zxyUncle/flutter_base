import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

//显示Toast
/// [debounce]：防抖功能
/// [consumeEvent]：true（toast会消耗触摸事件），false（toast不再消耗事件，触摸事件能穿透toast）
showToast(String? message, {bool debounce = true}) {
  SmartDialog.showToast(message ?? "", debounce: debounce);
}

///显示加载动画
/// [onDismiss]：在dialog被关闭的时候，该回调将会被触发
/// [displayTime] 控制弹窗在屏幕上显示时间; 默认为null, 为null则代表该参数不会控制弹窗关闭
showLoading({Duration? displayTime, VoidCallback? onDismiss}) {
  SmartDialog.showLoading(
      maskColor: Colors.black12,
      displayTime: displayTime,
      onDismiss: onDismiss);
}

//销毁dialog
dismissDialog() {
  SmartDialog.dismiss();
}

//自定义Dialog
/// [onDismiss]：在dialog被关闭的时候，该回调将会被触发
/// [displayTime] 控制弹窗在屏幕上显示时间; 默认为null, 为null则代表该参数不会控制弹窗关闭
showCustomDialog(Widget weiget,
    {Duration? displayTime, VoidCallback? onDismiss}) {
  SmartDialog.show(
      displayTime:displayTime,
      onDismiss: onDismiss,
      builder: (context) {
        return weiget;
      });
}

//通用的默认Dialog
/// [title] 标题
/// [titleFontSize] 标题字体大小
/// [titletColor] 标题颜色
/// [content] 内容
/// [contentFontSize] 内容字体大小
/// [contentColor] 内容颜色
/// [backColor] 对话框背景颜色
/// [onCancel] 取消对话框按钮回调、不传不显示
/// [cancelContent] 取消对话框按钮文案
/// [onConfrim] 确认对话框按钮回调、不传不显示
/// [confrimContent] 确认对话框按钮文案
/// [onDismiss] 对话框销毁回调
/// [displayTime] 控制弹窗在屏幕上显示时间; 默认为null, 为null则代表该参数不会控制弹窗关闭
showNormalDialog({
  String title = "",
  double? titleFontSize,
  Color? titletColor,
  String content = '',
  double? contentFontSize,
  Color? contentColor,
  Color backColor = Colors.white,
  Function()? onCancel,
  String cancelContent = "",
  Function()? onConfrim,
  String confrimContent = "",
  VoidCallback? onDismiss,
  Duration? displayTime,
}) {
  showCustomDialog(
    displayTime: displayTime,
    onDismiss: onDismiss,
    Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w), color: backColor),
        width: 280.w,
        padding: EdgeInsets.all(10.w),
        child: Wrap(
          children: [
            Column(
              children: [
                //标题
                title.isNotEmpty
                    ? Text(
                        title,
                        style: TextStyle(
                            fontSize: titleFontSize ?? 18.sp,
                            color: titletColor ?? Colors.black),
                      )
                    : const SizedBox(),
                //内容
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.w),
                  constraints: BoxConstraints(minHeight: 80.w),
                  child: Text(
                    content,
                    style: TextStyle(
                        fontSize: contentFontSize ?? 16.sp,
                        color: contentColor ?? Colors.black54),
                  ),
                ),
                //底部确认，跟取消按钮
                (onCancel != null || onConfrim != null)
                    ? Column(
                        children: [
                          Divider(height: 1.w, color: const Color(0xffe1e1e1)),
                          Row(
                            children: [
                              //取消
                              onCancel != null
                                  ? Expanded(
                                      child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: onCancel,
                                          child: Text(
                                            'dialog_cancel'.tr,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.black),
                                          )))
                                  : const SizedBox(),
                              //确认
                              onConfrim != null
                                  ? Expanded(
                                      child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: onConfrim,
                                          child: Text(
                                            'dialog_comfirm'.tr,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.black),
                                          )))
                                  : const SizedBox(),
                            ],
                          )
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        )),
  );
}

//加载中动画
//callBack BuildContext 返回回去做销毁
//barrierDismissible 是否可以点击取消
customDialog(
    {String status = "Loading..",
    Function(BuildContext)? callBack,
    bool barrierDismissible = false}) {
  showDialog(
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black12,
      context: Get.context!,
      builder: (dialogContext) {
        callBack?.call(dialogContext);
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
