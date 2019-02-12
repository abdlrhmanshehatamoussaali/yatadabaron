import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';

class CustomResearchTopicComment implements ISerializable {
  int CommentID;
  String Body;
  DateTime Date;
  int UserID;
  int TopicID;
  String UserName;
  String CountryNameAR;
  String CountryNameEN;

  //Related Entities
  Future fetchUser(UnitOfWork uow) async {
    
  }

  //Serialization
  @override
  CustomResearchTopicComment fromJSON(dynamic record) {
    try {
      CustomResearchTopicComment g = CustomResearchTopicComment();
      g.CommentID = int.parse(record["CommentID"].toString());
      g.TopicID = int.parse(record["TopicID"].toString());
      g.UserID = int.parse(record["UserID"].toString());
      g.Body = record["Body"];
      g.Date = DateTime.parse(record["Date"]);
      g.UserName = record["UserName"];
      g.CountryNameAR = record["CountryNameAR"];
      g.CountryNameEN = record["CountryNameEN"];
      return g;
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, String> toJSON(bool includeID) {
    return null;
  }

  @override
  Future fetchRelatedEntities(UnitOfWork uow) async {
    await fetchUser(uow);
  }
}
