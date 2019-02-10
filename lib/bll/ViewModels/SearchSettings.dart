import 'package:yatadabaron_flutter/dal/enums/EBasmalaMode.dart';
import 'package:yatadabaron_flutter/dal/enums/ESearchModes.dart';

class SearchSettings{
  String Keyword="";
  ESearchModes SearchMode=ESearchModes.Exactly;
  EBasmalaMode BasmalaMode=EBasmalaMode.Ignore;
  int ChapterID=1;
}