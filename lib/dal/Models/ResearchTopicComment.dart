import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Models/User.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';

class ResearchTopicComment implements ISerializable {
  int CommentID;
  String Body;
  DateTime Date;
  int UserID;
  int TopicID;

  User MyUser;

  //Related Entities
  Future fetchUser(UnitOfWork uow) async {
    var users = await uow.Users.fetch(
      {"UserID": this.UserID.toString()},
      true,
      uow,
    );
    this.MyUser = users.first;
  }

  //Serialization
  @override
  ResearchTopicComment fromJSON(dynamic record) {
    try {
      ResearchTopicComment g = ResearchTopicComment();
      g.CommentID = int.parse(record["CommentID"].toString());
      g.TopicID = int.parse(record["TopicID"].toString());
      g.UserID = int.parse(record["UserID"].toString());
      g.Body = record["Body"];
      g.Date = DateTime.parse(record["Date"]);
      return g;
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, String> toJSON(bool includeID) {
    Map<String, String> result = new Map();
    result["Body"] = this.Body;
    if(includeID){
      result["CommentID"] = this.CommentID.toString();
    }
    result["UserID"] = this.UserID.toString();
    result["TopicID"] = this.TopicID.toString();
    return result;
  }

  @override
  Future fetchRelatedEntities(UnitOfWork uow) async {
    await fetchUser(uow);
  }
}
