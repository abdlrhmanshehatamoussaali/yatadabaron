
import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';

class ResearchTopic implements ISerializable{
  int TopicID;
  String Title;
  DateTime Date;

  ResearchTopic fromJSON(dynamic record) {
    try {
      ResearchTopic g = ResearchTopic();
      g.TopicID = int.parse(record["TopicID"].toString());
      g.Title = record["Title"];
      g.Date = DateTime.parse(record["Date"]);
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
