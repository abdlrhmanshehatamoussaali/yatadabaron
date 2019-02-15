import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/Mappers/UOW.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/ChapterVM.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/VerseGenericVM.dart';
import 'package:yatadabaron_flutter/dal/Models/Chapter.dart';
import 'package:yatadabaron_flutter/pl/Shared/ChaptersDropDown.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class ReadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReadPage();
}

class _ReadPage extends State<ReadPage> {
  List<VerseGenericVM> _verses;
  int _chapterIndex;
  ChapterVM _chapter;

  Future update(int id) async {
    UOW uow = UOW();
    List<VerseGenericVM> verses = await uow.getVersesByChapterID(id);
    Chapter chapter = await uow.Chapters.getChapterByID(id);
    ChapterVM chapterVM = ChapterVM.mapSingle(chapter);
    setState(() {
      this._chapterIndex = id;
      this._verses = verses;
      this._chapter = chapterVM;
    });
  }

  @override
  Widget build(BuildContext context) {
    var innerStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    );
    var _searchResults = SharedWidgets.searchResults(this._verses);
    var _dropDown = ChaptersDropdown(this._chapterIndex, update, () {
      update(1);
    }, false, false,true,innerStyle);

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          _dropDown,
          _searchResults,
        ],
      ),
    );
  }
}
