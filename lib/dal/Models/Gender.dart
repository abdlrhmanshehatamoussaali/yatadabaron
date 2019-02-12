import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';

class Gender implements ISerializable{
  int GenderID;
  String TypeAR;
  String TypeEN;

  Gender fromJSON(dynamic record) {
    try {
      Gender g = Gender();
      g.GenderID = int.parse(record["GenderID"].toString());
      g.TypeAR = record["TypeAR"];
      g.TypeEN = record["TypeEN"];
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
