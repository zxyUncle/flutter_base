import 'package:flutter/cupertino.dart';

import '../common/const.dart';



class LoadingWidget extends StatelessWidget {
  final double? radius;

  const LoadingWidget({Key? key, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: primaryColor,
        radius: radius ?? 10,
      ),
    );
  }
}
