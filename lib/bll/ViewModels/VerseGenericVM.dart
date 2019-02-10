import 'package:yatadabaron_flutter/dal/Models/Verse.dart';

class VerseGenericVM{
  String header;
  String body;
  int index;


  static List<VerseGenericVM> mapAll(List<Verse> models) {
    List<VerseGenericVM> viewmodels = [];
    for (var i = 0; i < models.length; i++) {
      viewmodels.add(mapSingle(models[i]));
    }
    return viewmodels;
  }
  static VerseGenericVM mapSingle(Verse model){
     VerseGenericVM viewmodel = VerseGenericVM();
      viewmodel.body = model.TextTashkel;
      viewmodel.header = model.ChapterName??"";
      viewmodel.index=model.Index;
      return viewmodel;
  }
}
