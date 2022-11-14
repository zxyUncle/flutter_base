import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_bar_utils.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MineState();
  }
}

class _MineState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: noAppBar(backgroundColor: Colors.yellow),
      body: Center(
        child: TextField(),
      ),
    );
  }
}
