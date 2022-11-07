import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

//回弹
easyRefreshSpringBack({Widget? child}) {
  return EasyRefresh(
      child: CustomScrollView(
    slivers: [
      // SliverFillViewport(
      //   viewportFraction: 1.0,
      //   delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      //     return child;
      //   }, childCount: 1),
      // ),
      SliverToBoxAdapter(child: child ?? const SizedBox()),
    ],
  ));
}

//示例
EasyRefreshController _controller =
    EasyRefreshController(controlFinishRefresh: true, controlFinishLoad: true);

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
