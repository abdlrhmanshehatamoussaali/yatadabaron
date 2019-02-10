import 'package:yatadabaron_flutter/dal/Models/Chapter.dart';
import 'package:yatadabaron_flutter/dal/enums/EBasmalaMode.dart';
import 'package:yatadabaron_flutter/utils/DatabaseHelper.dart';

class ChaptersRepository {
  Future<List<Chapter>> getChapters() async {
    String query = "select * from chapters";
    List<Map<String, dynamic>> chaptersDB =
        await DatabaseHelper.ExcuteReaderQuery(query);
    List<Chapter> chapters = [];
    for (var chapterDB in chaptersDB) {
      Chapter chapter = Chapter();
      chapter.ArName = chapterDB["arabic"];
      chapter.EnName = chapterDB["latin"];
      chapter.ID = chapterDB["c0sura"];
      chapter.Location = int.parse(chapterDB["localtion"]);
      chapter.Sajda = int.parse(chapterDB["sajda"]);
      chapter.Size = chapterDB["ayah"];
      chapters.add(chapter);
    }
    return chapters;
  }

  Future<Chapter> getChapterByID(int id) async {
    String query = "select * from chapters where c0sura = $id";
    List<Map<String, dynamic>> chaptersDB =
        await DatabaseHelper.ExcuteReaderQuery(query);
    List<Chapter> chapters = [];
    for (var chapterDB in chaptersDB) {
      Chapter chapter = Chapter();
      chapter.ArName = chapterDB["arabic"];
      chapter.EnName = chapterDB["latin"];
      chapter.ID = chapterDB["c0sura"];
      chapter.Location = int.parse(chapterDB["localtion"]);
      chapter.Sajda = int.parse(chapterDB["sajda"]);
      chapter.Size = chapterDB["ayah"];
      chapters.add(chapter);
    }
    return chapters[0];
  }

  Future<List<String>> getChapterNames() async {
    String query = "select arabic from chapters";
    List<Map<String, dynamic>> chapterNamesDB =
        await DatabaseHelper.ExcuteReaderQuery(query);
    List<String> names = [];
    for (Map<String, dynamic> chapterNameDB in chapterNamesDB) {
      names.add(chapterNameDB["arabic"].toString());
    }
    return names;
  }

  static const List<String> _arabicLetters = [
    "ء",
    "آ",
    "ا",
    "أ",
    "إ",
    "ب",
    "ت",
    "ة",
    "ث",
    "ج",
    "ح",
    "خ",
    "د",
    "ذ",
    "ر",
    "ز",
    "س",
    "ش",
    "ص",
    "ض",
    "ط",
    "ظ",
    "ع",
    "غ",
    "ف",
    "ق",
    "ك",
    "ل",
    "م",
    "ن",
    "ه",
    "و",
    "ؤ",
    "ي",
    "ئ",
    "ى"
  ];

  Future<Map<String, int>> GetLettersFrequency(EBasmalaMode basmala,[int id = 0]) async {
    String condition = (id >= 1 && id <= 114) ? "where sura=$id" : "";
    //0 basmala //1 no basmala
    String from = (basmala == EBasmalaMode.Consider) ? "verses" : "verses_no_basmala";

    //"select sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))) from $from $condition";
    /*"select sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))), sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s',''))),sum(length(text)-length(replace(text,'%s','')))from $from $condition";*/
    List<int> result = [];
    String query = "select ";
    for (var i = 0; i < _arabicLetters.length; i++) {
      String l = _arabicLetters[i];
      query += "sum(length(text)-length(replace(text,'$l',''))) as l$i ,";
    }
    query = query.substring(0,query.length-1);
    query += "from $from $condition";
    List<Map<String, dynamic>> lettersCountDB = await DatabaseHelper.ExcuteReaderQuery(query);
    if (lettersCountDB.length > 0) {
      for (var i = 0; i < lettersCountDB[0].length; i++) {
        var count = lettersCountDB[0]["l$i"];
        result.add(count);
      }
    }

    Map<String, int> results = Map();
    for (var i = 0; i < result.length; i++) {
      String letter = ChaptersRepository._arabicLetters[i];
      int count = result[i];
      results[letter] = count;
    }
    return results;
  }
}
