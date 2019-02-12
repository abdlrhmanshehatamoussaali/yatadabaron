import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';

class Country implements ISerializable{
  int CountryID;
  String NameEN;
  String NameAR;

  @override
  Country fromJSON(Map<String, dynamic> record) {
    try {
      Country g = Country();
      g.CountryID = int.parse(record["CountryID"].toString());
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
