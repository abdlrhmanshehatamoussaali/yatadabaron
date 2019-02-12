import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/pl/Shared/CustomErrorWidget.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class CustomDropdown extends StatelessWidget {
  dynamic selectedValue;
  String error;
  Function onChange;
  Function getValue;
  Function getText;
  bool isExpanded;
  bool isDense;
  List<dynamic> entities;

  CustomDropdown(
    this.entities,
    this.selectedValue,
    this.getValue,
    this.getText,
    this.onChange, {
    this.isExpanded: false,
    this.isDense: false,
    this.error: null,
  });

  @override
  Widget build(BuildContext context) {
    if (entities == null || (this.entities.length == 0)) {
      return Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }

    var items = this.entities.map<DropdownMenuItem>((e) {
      return DropdownMenuItem(
        value: getValue(e),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: Utils.getTextDirection(),
            children: <Widget>[
              Text(
                getText(e),
                textDirection: Utils.getTextDirection(),
              ),
            ],
          ),
        ),
      );
    }).toList();
    var dropdown = DropdownButton(
      items: items,
      value: selectedValue,
      isExpanded: isExpanded,
      isDense: this.isDense,
      onChanged: (x) async {
        await onChange(x);
      },
    );
    var container;
    if (error != null) {
      var errorWidget = CustomErrorWidget(error);
      container = Row(
        textDirection: Utils.getTextDirection(),
        children: <Widget>[
          Expanded(
            flex: 3,
            child: dropdown,
          ),
          Expanded(
            flex: 1,
            child: errorWidget,
          ),
        ],
      );
    } else {
      container = dropdown;
    }
    return container;
  }
}
