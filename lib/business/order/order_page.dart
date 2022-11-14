import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_bar_utils.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OrderState();
  }
}

class _OrderState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: noAppBar(backgroundColor: Colors.green),
      body: Center(
        child: TextField(),
      ),
    );
  }
}
