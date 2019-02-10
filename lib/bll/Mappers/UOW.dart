import 'package:yatadabaron_flutter/bll/ViewModels/ChapterVM.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/LetterFrequency.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/VerseGenericVM.dart';
import 'package:yatadabaron_flutter/dal/Models/Chapter.dart';
import 'package:yatadabaron_flutter/dal/Models/Verse.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/dal/enums/EBasmalaMode.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class UOW extends UnitOfWork {
  UOW() : super();

  Future<ChapterVM> getChapterByID(int id) async {
    Chapter chapter = await this.Chapters.getChapterByID(id);
    ChapterVM chapterVM = ChapterVM.mapSingle(chapter);
    return chapterVM;
  }

  Future<List<VerseGenericVM>> getVersesByChapterID(int id) async {
    List<Verse> verses = await this.Verses.GetVersesByChapterID(id);
    List<VerseGenericVM> versesVM = VerseGenericVM.mapAll(verses);
    return versesVM;
  }

  Future<List<ChapterVM>> getChaptersforDropdown(
      [bool includeWholeQuran = false]) async {
    List<Chapter> chapters = await this.Chapters.getChapters();
    List<ChapterVM> chaptersVM = ChapterVM.mapAll(chapters);
    if (includeWholeQuran) {
      chaptersVM.insert(0, Utils.quranChapter());
    }
    return chaptersVM;
  }

  Future<List<LetterFrequency>> getLettersFrequencies(EBasmalaMode mode,int id) async {
    Map<String, int> models = await this.Chapters.GetLettersFrequency(
        mode, id);
    List<LetterFrequency> viewModels = LetterFrequency.MapAll(models);
    return viewModels;
  }
}
