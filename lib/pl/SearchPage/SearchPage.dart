import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/SearchSettings.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/UserSettings.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/VerseGenericVM.dart';
import 'package:yatadabaron_flutter/dal/Models/Verse.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/SearchPage/SearchSettingsWidget.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SerachPage();
  }
}

class _SerachPage extends State<SearchPage> {
  List<VerseGenericVM> _results = [];
  SearchSettings _settings = SearchSettings();

  Future _search() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    UnitOfWork uow = UnitOfWork();
    List<Verse> _verses = await uow.Verses.GetVersesContaining(
        _settings.ChapterID,
        _settings.Keyword,
        _settings.SearchMode,
        _settings.BasmalaMode);
    List<VerseGenericVM> _versesVM = VerseGenericVM.mapAll(_verses);
    setState(() {
      this._results = _versesVM;
    });

    if (_settings.Keyword.isNotEmpty) {
      //Increase no of uses
      UserSettings u = await Utils.getUserSettings();
      int no = int.tryParse(u.noOfUses) ?? 0;
      u.noOfUses = (no + 1).toString();
      await Utils.setUserSettings(u);

      //Popup the rating dialog based on criteria
      await Utils.showRatingDialog(context);
    }
  }

  void _updateSettings(SearchSettings settings) async {
    setState(() {
      this._settings = settings;
    });
    await _search();
  }

  Widget _searchSummary() {
    String summary = "";
    Color color = Colors.red[300];
    if (_settings.Keyword.isEmpty) {
      summary = Utils.getText(23);
    } else {
      if (_results.length > 0) {
        var s12 = Utils.getText(12);
        s12 = s12.replaceAll("%", _results.length.toString());
        summary = s12 + "[ " + _settings.Keyword + " ]";
        color = Theme.of(context).accentColor;
      } else {
        summary = Utils.getText(22);
      }
    }

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Text(
        summary,
        textDirection: Utils.getTextDirection(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _searchForm() {
    var buttonSerach = Container(
      padding: EdgeInsets.all(1),
      child: RaisedButton(
        child: Text(
          Utils.getText(11),
          textDirection: Utils.getTextDirection(),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () async {
          await this._search();
        },
      ),
    );

    var textfield = TextField(
      decoration: InputDecoration(
        hintText: Utils.getText(4),
      ),
      onChanged: (x) {
        this._settings.Keyword = x;
      },
      onSubmitted: (x) async {
        await this._search();
      },
      textDirection: Utils.getTextDirection(),
      textAlign: TextAlign.center,
    );
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        textDirection: Utils.getTextDirection(),
        children: <Widget>[
          Expanded(
            child: textfield,
            flex: 1,
          ),
          buttonSerach,
        ],
      ),
    );
  }

  @override
  void initState() {
    _settings.ChapterID = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _appBar = SharedWidgets.customAppBar(Utils.getText(40));
    var _searchResults = SharedWidgets.searchResults(_results, true);
    return Scaffold(
      appBar: _appBar,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            _searchForm(),
            SearchSettingsWidget(_settings, this._updateSettings),
            _searchSummary(),
            _searchResults
          ],
        ),
      ),
    );
  }
}
