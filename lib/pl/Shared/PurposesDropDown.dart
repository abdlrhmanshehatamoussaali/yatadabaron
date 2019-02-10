import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/Mappers/UOW.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/ChapterVM.dart';
import 'package:yatadabaron_flutter/dal/Models/Gender.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchPurpose.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class PurposesDropdown extends StatefulWidget {
  int initialValue;
  Function onChange;
  Function executeOnStart;
  bool isExplanded;

  PurposesDropdown(this.initialValue, this.onChange,
      [this.executeOnStart,
      this.isExplanded = false]);

  @override
  State<StatefulWidget> createState() => _PurposesDropdown();
}

class _PurposesDropdown extends State<PurposesDropdown> {
  List<ResearchPurpose> _entities;

  @override
  void initState() {
    UOW uow = UOW();
    uow.Purposes.getAll().then((entities) {
      setState(() {
        this._entities = entities;
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

    if (this._entities != null) {
      List<DropdownMenuItem> items = this._entities.map<DropdownMenuItem>((e) {
        return DropdownMenuItem(
          value:e.PurposeID,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: Utils.getTextDirection(),
              children: <Widget>[
                Text(
                  e.NameAR,
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
