import 'package:yatadabaron_flutter/dal/Models/Chapter.dart';

class ChapterVM{
  String StringifiedLocation;
  String StringifiedSize;
  String NameWithNumber;
  String Summary;
  String ArName;
  int ID;

  static List<ChapterVM> mapAll(List<Chapter> models) {
    List<ChapterVM> viewmodels = [];
    for (var model in models) {
      viewmodels.add(mapSingle(model));
    }
    return viewmodels;
  }

  static ChapterVM mapSingle(Chapter model) {
    ChapterVM viewmodel = ChapterVM();
    viewmodel.ArName = model.ArName;
    viewmodel.ID = model.ID;
    viewmodel.StringifiedLocation = model.Location == 1 ? "مكية" : "مدنية";
    viewmodel.StringifiedSize = model.Size.toString() + " آية";
    viewmodel.NameWithNumber = model.ID.toString() + ". " + model.ArName;
    viewmodel.Summary =viewmodel.StringifiedLocation + " - " + viewmodel.StringifiedSize;
    return viewmodel;
  }
}
