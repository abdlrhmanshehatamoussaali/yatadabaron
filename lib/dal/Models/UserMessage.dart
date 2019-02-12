import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';

class UserMessage implements ISerializable{
  int MessageID;
  int UserID;
  String Body;
  DateTime Date;

  UserMessage fromJSON(dynamic record) {
    try {
      UserMessage g = UserMessage();
      g.UserID = int.parse(record["UserID"].toString());
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
