import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;

  CustomErrorWidget(this.error);

  @override
  Widget build(BuildContext context) {
    var errorWidget = Text(
      this.error,
      textDirection: Utils.getTextDirection(),
      style: TextStyle(color: Colors.red, fontSize: 12),
    );
    return errorWidget;
  }
}
