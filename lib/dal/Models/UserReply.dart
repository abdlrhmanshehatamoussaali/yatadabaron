
import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';

class UserReply implements ISerializable{
  int ReplyID;
  int MessageID;
  String Body;
  DateTime Date;


  UserReply fromJSON(dynamic record) {
    try {
      UserReply g = UserReply();
      g.ReplyID = int.parse(record["ReplyID"].toString());
      g.MessageID = int.parse(record["MessageID"].toString());
      g.Body = record["Body"];
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