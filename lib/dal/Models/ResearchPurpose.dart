import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';

class ResearchPurpose implements ISerializable{
  int PurposeID;
  String NameEN;
  String NameAR;

  ResearchPurpose fromJSON(dynamic record) {
    try {
      ResearchPurpose g = ResearchPurpose();
      g.PurposeID = int.parse(record["PurposeID"].toString());
      g.NameAR = record["NameAR"];
      g.NameEN = record["NameEN"];
      return g;
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, String> toJSON(bool includeID) {
    // TODO: implement toJSON
    return null;
  }

  @override
  Future fetchRelatedEntities(UnitOfWork uow) async{
    // TODO: implement fetchRelatedEntities
  }

  
}
