
import 'package:yatadabaron_flutter/dal/Models/Verse.dart';
import 'package:yatadabaron_flutter/dal/enums/EBasmalaMode.dart';
import 'package:yatadabaron_flutter/dal/enums/ESearchModes.dart';
import 'package:yatadabaron_flutter/utils/DatabaseHelper.dart';

class VersesRepository {
  Future<List<Verse>> GetVersesContaining(int id,String keyword, ESearchModes searchMode,EBasmalaMode basmala ) async {
    List<Verse> verses = [];
    if(keyword.isEmpty){
      return verses;
    }
    String keyWordCondition="";//0 exact//1 contains//2 ends with //3 ends with
    switch (searchMode) {
      case ESearchModes.Exactly:
        keyWordCondition = "where (text like '% $keyword %' or text like '$keyword %' or text like '% $keyword')";
        break;
      case ESearchModes.Contains:
        keyWordCondition = "where (text like '%$keyword%')";
        break;
      case ESearchModes.EndsWith:
        keyWordCondition = "where (text like '%$keyword')";
        break;
      case ESearchModes.StartsWith:
        keyWordCondition = "where (text like '$keyword%')";
        break;
    }
    String suraCondition = "";
    if(id > 0){
      suraCondition = " and (sura = $id )";
    }
    String from = (basmala==EBasmalaMode.Consider) ? "verses":"verses_no_basmala";//0 basmala //1 no basmala

    String query =
        "select $from.*,chapters.arabic as chapter_name from $from inner join chapters on chapters.c0sura = $from.sura $keyWordCondition $suraCondition";
    List<Map<String, dynamic>> versesDB =
        await DatabaseHelper.ExcuteReaderQuery(query);
    for (var verseDB in versesDB) {
      Verse v = Verse();
      v.ChapterID = verseDB["sura"];
      v.Index = verseDB["ayah"];
      v.TextTashkel = verseDB["text_tashkel"];
      v.Text = verseDB["text"];
      v.ChapterName = verseDB["chapter_name"];
      verses.add(v);
    }
    return verses;
  }

  Future<List<Verse>> GetVerses() async {
    List<Verse> verses = [];
    String query = "select * from verses";
    List<Map<String, dynamic>> versesDB =
        await DatabaseHelper.ExcuteReaderQuery(query);
    for (var verseDB in versesDB) {
      Verse v = Verse();
      v.ChapterID = verseDB["sura"];
      v.Index = verseDB["ayah"];
      v.TextTashkel = verseDB["text_tashkel"];
      v.Text = verseDB["text"];
      verses.add(v);
    }
    return verses;
  }

  Future<List<Verse>> GetVersesByChapterID(int id) async {
    List<Verse> verses = [];
    String query = "select * from verses where sura = $id";
    List<Map<String, dynamic>> versesDB =
        await DatabaseHelper.ExcuteReaderQuery(query);
    for (var verseDB in versesDB) {
      Verse v = Verse();
      v.ChapterID = verseDB["sura"];
      v.Index = verseDB["ayah"];
      v.TextTashkel = verseDB["text_tashkel"];
      v.Text = verseDB["text"];
      verses.add(v);
    }
    return verses;
  }
}
