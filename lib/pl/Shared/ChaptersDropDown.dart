import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/Mappers/UOW.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/ChapterVM.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class ChaptersDropdown extends StatefulWidget {
  int initialValue;
  Function onChange;
  Function executeOnStart;
  bool wholeQuranIncluded;
  bool isExpanded;
  bool withSummary;
  TextStyle innerStyle;

  ChaptersDropdown(this.initialValue, this.onChange,
      [this.executeOnStart,
      this.wholeQuranIncluded = false,
      this.isExpanded = false,
      this.withSummary = false,
      this.innerStyle = null]);

  @override
  State<StatefulWidget> createState() => _ChaptersDropDown();
}

class _ChaptersDropDown extends State<ChaptersDropdown> {
  List<ChapterVM> _chapters;

  @override
  void initState() {
    UOW uow = UOW();
    uow.getChaptersforDropdown(widget.wholeQuranIncluded).then((chapters) {
      setState(() {
        this._chapters = chapters;
        if (widget.executeOnStart != null) {
          widget.executeOnStart();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chaptersDropDown;

    if (this._chapters != null) {
      List<DropdownMenuItem> items = this._chapters.map<DropdownMenuItem>((c) {
        var name = c.ArName;
        if (widget.withSummary) {
          name = c.ArName + "       " + c.Summary;
        }
        return DropdownMenuItem(
          value: c.ID,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: Utils.getTextDirection(),
              children: <Widget>[
                Text(
                  name,
                  style: widget.innerStyle,
                  textDirection: Utils.getTextDirection(),
                ),
              ],
            ),
          ),
        );
      }).toList();

      chaptersDropDown = DropdownButton(
        items: items,
        value: widget.initialValue,
        isExpanded: widget.isExpanded,
        onChanged: (x) async {
          setState(() {
            widget.initialValue = x;
          });
          await widget.onChange(x);
        },
      );
    } else {
      chaptersDropDown = CircularProgressIndicator();
    }
    return chaptersDropDown;
  }
}
