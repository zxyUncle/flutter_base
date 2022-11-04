import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final EasyRefreshController _controller = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              //_nextPage(-1);
            },
          ),
          title: Text('login_title'.tr, textAlign: TextAlign.center),
        ),
        // body: Center(child: Text('123123'),),
        body: _easyRefresh(),
      ),
    );
  }

  _easyRefresh() {
    return EasyRefresh(
        controller: _controller,
        onRefresh: () async {
          _controller.finishRefresh();
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
                child: Text(
                    '1231111111111\n111111111\n111111111\n111111111\n111111111\n111111111\n111111111'),
              ),
            )
          ],
        ));
  }
}
