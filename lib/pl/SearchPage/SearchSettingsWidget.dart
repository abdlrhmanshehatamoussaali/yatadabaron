import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/SearchSettings.dart';
import 'package:yatadabaron_flutter/dal/enums/EBasmalaMode.dart';
import 'package:yatadabaron_flutter/dal/enums/ESearchModes.dart';
import 'package:yatadabaron_flutter/pl/Shared/ChaptersDropDown.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class SearchSettingsWidget extends StatefulWidget {
  Function _updateSettings;
  SearchSettings settings;

  SearchSettingsWidget(this.settings, this._updateSettings);
  @override
  State<StatefulWidget> createState() {
    return _SearchSettingsWidget();
  }
}

class _SearchSettingsWidget extends State<SearchSettingsWidget> {
  @override
  void initState() {
    widget.settings.ChapterID = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchModesDropDownMenuItems = [
      DropdownMenuItem(
        value: ESearchModes.Exactly,
        child: Text(Utils.getText(5)),
      ),
      DropdownMenuItem(
        value: ESearchModes.Contains,
        child: Text(Utils.getText(6)),
      ),
      DropdownMenuItem(
        value: ESearchModes.StartsWith,
        child: Text(Utils.getText(7)),
      ),
      DropdownMenuItem(
        value: ESearchModes.EndsWith,
        child: Text(Utils.getText(8)),
      )
    ];
    var searchModesDropDown = DropdownButton(
      items: searchModesDropDownMenuItems,
      value: widget.settings.SearchMode,
      onChanged: (x) async {
        setState(() {
          widget.settings.SearchMode = x;
        });
        await widget._updateSettings(widget.settings);
        ;
      },
    );
    var basmalaModesDropDown = DropdownButton(
      items: [
        DropdownMenuItem(
          value: EBasmalaMode.Ignore,
          child: Text(Utils.getText(10)),
        ),
        DropdownMenuItem(
          value: EBasmalaMode.Consider,
          child: Text(Utils.getText(21)),
        )
      ],
      value: widget.settings.BasmalaMode,
      onChanged: (x) async {
        setState(() {
          widget.settings.BasmalaMode = x;
        });
        await widget._updateSettings(widget.settings);
      },
    );
    var onChanged = (x) async {
      setState(() {
        widget.settings.ChapterID = x;
      });
      await widget._updateSettings(widget.settings);
    };
    var chaptersDropDown = ChaptersDropdown(widget.settings.ChapterID, onChanged, null, true);
    var widgetsListView = Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      height: 55,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Row(
            children: [
              chaptersDropDown,
              Text(" "),
              basmalaModesDropDown,
              Text(" "),
              searchModesDropDown,
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: Utils.getTextDirection(),
          )
        ],
      ),
    );
    return Card(
      child: widgetsListView,
    );
  }
}
