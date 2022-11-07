import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//回弹
easyRefreshSpringBack({Widget? child}) {
  return EasyRefresh(
      child: CustomScrollView(
    slivers: [
      SliverToBoxAdapter(child: child ?? const SizedBox()),
    ],
  ));
}

//示例
EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true, controlFinishLoad: true);

_easyRefresh() {
  return EasyRefresh(
      controller: _controller,
      onRefresh: () async {
        _controller.finishRefresh();
        _controller.resetFooter();
      },
      onLoad: () async {
        _controller.finishLoad(IndicatorResult.noMore);
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.red,
              width: double.infinity,
              child: const Text(
                  '1231111111111\n111111111\n111111111\n111111111\n111111111\n111111111\n111111111'),
            ),
          )
        ],
      ));
}