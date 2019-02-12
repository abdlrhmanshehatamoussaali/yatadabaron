import 'package:yatadabaron_flutter/dal/Models/CustomResearchTopicComment.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopicComment.dart';
import 'package:yatadabaron_flutter/dal/Models/User.dart';
import 'package:yatadabaron_flutter/dal/Repositories/GenericRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/resources/Client.dart';

class ResearchTopicCommentsRepository
    extends GenericRepository<ResearchTopicComment> {
  UnitOfWork uow;

  ResearchTopicCommentsRepository(UnitOfWork u) {
    this.uow = u;
  }

  Future<List<CustomResearchTopicComment>> getCustom(
      [Map<String, String> map = null]) async {
    var response = await Client.getResource("ResearchTopicComments/getCustom.php", map);

    List<CustomResearchTopicComment> comments =
        List<CustomResearchTopicComment>();
    try {
      var records = response["records"];
      for (var record in records) {
        CustomResearchTopicComment comment =
            CustomResearchTopicComment().fromJSON(record);
        comments.add(comment);
      }
    } catch (e) {
      print(e);
    }
    return comments;
  }
}
