import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/business/home/home_page.dart';
import 'package:flutter_base/business/mine/mine_page.dart';
import 'package:flutter_base/business/order/order_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common/const.dart';
import 'KeepAliveWrapper.dart';

class MyTabbar extends StatefulWidget {
  const MyTabbar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyTabbarState();
  }
}

class _MyTabbarState extends State<MyTabbar> {
  Color? selectBgColors = Colors.red;
  Color? selectColor;
  int _currentIndex = 0;
  final _pageController = PageController();
  final List<Widget> _pageList = [
    const KeepAliveWrapper(child: HomePage()),
    const KeepAliveWrapper(child: OrderPage()),
    const KeepAliveWrapper(child: MinePage())
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pageList[index];
        },
        itemCount: _pageList.length,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14.sp,
        unselectedFontSize: 14.sp,
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
                    "${assetImage}order/${_currentIndex == 1 ? 'order_select' : 'order_unselect'}.png"),
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
                    "${assetImage}mine/${_currentIndex == 2 ? 'mine_select' : 'mine_unselect'}.png"),
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
