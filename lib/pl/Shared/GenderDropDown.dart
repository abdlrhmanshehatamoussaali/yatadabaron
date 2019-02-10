import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/Mappers/UOW.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/ChapterVM.dart';
import 'package:yatadabaron_flutter/dal/Models/Gender.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class GenderDropdown extends StatefulWidget {
  int initialValue;
  Function onChange;
  Function executeOnStart;
  bool isExplanded;

  GenderDropdown(this.initialValue, this.onChange,
      [this.executeOnStart,
      this.isExplanded = false]);

  @override
  State<StatefulWidget> createState() => _GenderDropdown();
}

class _GenderDropdown extends State<GenderDropdown> {
  List<Gender> _genders;

  @override
  void initState() {
    UOW uow = UOW();
    uow.Genders.getAll().then((genders) {
      setState(() {
        this._genders = genders;
        if (widget.executeOnStart != null) {
          widget.executeOnStart();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gendersDropDown;

    if (this._genders != null) {
      List<DropdownMenuItem> items = this._genders.map<DropdownMenuItem>((g) {
        return DropdownMenuItem(
          value: g.GenderID,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: Utils.getTextDirection(),
              children: <Widget>[
                Text(
                  g.TypeAR,
                  textDirection: Utils.getTextDirection(),
                ),
              ],
            ),
          ),
        );
      }).toList();

      gendersDropDown = DropdownButton(
        items: items,
        value: widget.initialValue,
        isExpanded: widget.isExplanded,
        onChanged: (x) async {
          setState(() {
            widget.initialValue = x;
          });
          await widget.onChange(x);
        },
      );
    } else {
      gendersDropDown = CircularProgressIndicator();
    }
    return gendersDropDown;
  }
}
