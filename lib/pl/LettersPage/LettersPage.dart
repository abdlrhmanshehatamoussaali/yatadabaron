import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/Mappers/UOW.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/LetterFrequency.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/LettersSettings.dart';
import 'package:yatadabaron_flutter/bll/enums/ELetterPresentationTypes.dart';
import 'package:yatadabaron_flutter/dal/enums/EBasmalaMode.dart';
import 'package:yatadabaron_flutter/pl/LettersPage/LettersChart.dart';
import 'package:yatadabaron_flutter/pl/LettersPage/LettersTable.dart';
import 'package:yatadabaron_flutter/pl/Shared/ChaptersDropDown.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class LettersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LettersPage();
  }
}

class _LettersPage extends State<LettersPage> {
  List<LetterFrequency> _frequencies = [];
  LettersSettings _settings = LettersSettings();

  Widget _settingsPanel() {
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
      value: _settings.BasmalaMode,
      onChanged: (x) async {
        setState(() {
          this._settings.BasmalaMode = x;
        });
        await _getFrequencies();
      },
    );

    var chartTypeDropdown = DropdownButton(
      items: [
        DropdownMenuItem(
          child: Text(Utils.getText(15)),
          value: ELetterPresentationTypes.Chart,
        ),
        DropdownMenuItem(
          child: Text(Utils.getText(16)),
          value: ELetterPresentationTypes.Table,
        ),
      ],
      value: this._settings.PresentationType,
      onChanged: (x) async {
        setState(() {
          this._settings.PresentationType = x;
        });
        await _getFrequencies();
      },
    );

    return Card(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        height: 45,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            Row(
              children: [
                basmalaModesDropDown,
                Text("     "),
                chartTypeDropdown,
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: Utils.getTextDirection(),
            )
          ],
        ),
      ),
    );
  }

  Widget _presentationWidget() {
    if (this._settings.PresentationType == ELetterPresentationTypes.Table) {
      return LettersTable(this._frequencies);
    } else {
      return LettersChart(this._frequencies);
    }
  }

  Future _getFrequencies() async {
    UOW uow = UOW();
    var freqs = await uow.getLettersFrequencies(
        _settings.BasmalaMode, _settings.ChapterIndex);
    setState(() {
      _frequencies = freqs;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void dropDownOnChange(int id) {
    setState(() {
      _settings.ChapterIndex = id;
    });
    _getFrequencies();
  }

  @override
  Widget build(BuildContext context) {
    var onStart = () {
      _getFrequencies();
    };
    var _chaptersDropdown = ChaptersDropdown(
        _settings.ChapterIndex, dropDownOnChange, onStart, true, true);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _chaptersDropdown,
          _settingsPanel(),
          _presentationWidget(),
        ],
      ),
    );
  }
}
