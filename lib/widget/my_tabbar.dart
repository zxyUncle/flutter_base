//PageView+
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/business/home/home_page.dart';
import 'package:flutter_base/business/mine/mine_page.dart';
import 'package:flutter_base/business/order/order_page.dart';

class MyTabbar extends StatefulWidget {
  final _pageController = PageController();

  @override
  State<StatefulWidget> createState() {
    return _MyTabbarState();
  }
}

class _MyTabbarState extends State<MyTabbar> {
  final List<Widget> _pageList = [
    const HomePage(),
    const OrderPage(),
    const MinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(itemBuilder: (BuildContext context, int index) {
        return _pageList[index];
      }),
    );
  }
}
