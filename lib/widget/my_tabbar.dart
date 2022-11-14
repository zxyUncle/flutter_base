import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/business/home/home_page.dart';
import 'package:flutter_base/business/mine/mine_page.dart';
import 'package:flutter_base/business/order/order_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common/const.dart';

class MyTabbar extends StatefulWidget {
  const MyTabbar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyTabbarState();
  }
}

class _MyTabbarState extends State<MyTabbar> {
  Color? selectBgColors;
  Color? selectColor;
  int _currentIndex = 0;
  final _pageController = PageController();
  final List<Widget> _pageList = [
    const HomePage(),
    const OrderPage(),
    const MinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pageList[index];
        },
        itemCount: _pageList.length,
        controller: _pageController,
        // physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14.sp,
        unselectedFontSize: 10.sp,
        backgroundColor: selectBgColors,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image(
                image: AssetImage(
                    "${assetImage}home/${_currentIndex == 0 ? 'home_unselect' : 'home_select'}.png"),
                width: 25.w,
                height: 25.w,
              ),
            ),
            label: "tab_main".tr,
            tooltip: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image(
                image: AssetImage(
                    "${assetImage}home/${_currentIndex == 1 ? 'home_unselect' : 'home_select'}.png"),
                width: 25.w,
                height: 25.w,
              ),
            ),
            label: "tab_order".tr,
            tooltip: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image(
                image: AssetImage(
                    "${assetImage}home/${_currentIndex == 2 ? 'home_unselect' : 'home_select'}.png"),
                width: 25.w,
                height: 25.w,
              ),
            ),
            label: "tab_mine".tr,
            tooltip: "",
          ),
        ],
        onTap: (int position) {
          switch (position) {
            case 0:
              selectBgColors = Colors.red;
              break;
            case 1:
              selectBgColors = Colors.green;
              break;
            case 2:
              selectBgColors = Colors.yellow;
              break;
          }
          setState(() {
            _currentIndex = position;
          });
          _pageController.jumpToPage(position);
        },
      ),
    );
  }
}
