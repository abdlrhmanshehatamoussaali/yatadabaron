import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/resources/Client.dart';

class GenericRepository<T extends ISerializable> {
  Future<List<T>> fetch([
    Map<String, String> paramsMap = null,
    loadRelatedEntities = false,
    UnitOfWork uow = null,
  ]) async {
    List<T> results = await Client.getEntity<T>(paramsMap);
    if (loadRelatedEntities) {
      for (var result in results) {
        await result.fetchRelatedEntities(uow);
      }
    }
    return results;
  }

  Future<int> count([Map<String,String> map = null]) {
    return Client.countEntity<T>(map);
  }

   Future<bool> add(T entity) async {
    var done = await Client.post(Client.endpointsMap()[T],entity.toJSON(false));
    return (done != null) && (done.toString() == "1");
  }
}
