import 'package:flutter/material.dart';
import 'package:flutter_base/utils/app_bar_utils.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: noAppBar(backgroundColor: Colors.red),
      body: Center(
        child: Text('tab_main'.tr),
      ),
    );
  }
}
