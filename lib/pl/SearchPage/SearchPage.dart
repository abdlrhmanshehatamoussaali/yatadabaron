import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/SearchSettings.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/UserSettings.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/VerseGenericVM.dart';
import 'package:yatadabaron_flutter/dal/Models/Verse.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/SearchPage/SearchSettingsWidget.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/Localization.dart';
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

  String _searchSummaryText() {
    String summary = "";
    //Color color = Colors.red[300];
    if (_settings.Keyword.isEmpty) {
      summary = Utils.getText(23);
    } else {
      if (_results.length > 0) {
        var s12 = Utils.getText(12);
        s12 = s12.replaceAll("%", _results.length.toString());
        summary = s12 + "[ " + _settings.Keyword + " ]";
        //color = Theme.of(context).accentColor;
      } else {
        summary = Utils.getText(22);
      }
    }
    return summary;
  }

  Widget _searchForm() {
    var textfield = Directionality(
      textDirection: Utils.getTextDirection(),
      child: TextField(
        decoration: InputDecoration(
          hintText: Utils.localize(Localization.SEARCH_KEYWORD_HERE),
          //labelText: Utils.localize(Localization.SEARCH_KEYWORD_HERE),
          fillColor: Colors.grey,
          isDense: true,
          errorText: _searchSummaryText(),
        ),
        onChanged: (x) {
          this._settings.Keyword = x;
        },
        onSubmitted: (x) async {
          await this._search();
        },
        textDirection: Utils.getTextDirection(),
        textAlign: TextAlign.center,
      ),
    );
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: textfield,
            flex: 1,
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.green,
            onPressed: () async{
              await this._search();
            },
          )
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
    var _searchResults = SharedWidgets.searchResults(_results, true);
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          _searchForm(),
          SearchSettingsWidget(_settings, this._updateSettings),
          //_searchSummary(),
          _searchResults
        ],
      ),
    );
  }
}
