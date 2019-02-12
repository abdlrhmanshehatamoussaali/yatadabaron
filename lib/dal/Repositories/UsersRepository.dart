import 'package:yatadabaron_flutter/dal/Models/User.dart';
import 'package:yatadabaron_flutter/dal/Repositories/GenericRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/resources/Client.dart';

class UsersRepository extends GenericRepository<User>{
  UnitOfWork uow;

  UsersRepository(UnitOfWork u){
    this.uow = u;
  }
 
  Future<User> authenticate(String email, String password) async {
    Map<String, String> body = Map<String, String>();
    body["Email"] = email;
    body["Password"] = password;
    var response =
        await Client.post("Users", body, customPath: "authenticate.php");
    User user = null;
    if (response != null) {
      user = User().fromJSON(response);
      await user.fetchRelatedEntities(uow);
    }
    return user;
  }

  Future<bool> add(User user) async {
    var done = await Client.post("Users", user.toJSON(false));
    return (done != null) && (done == "1");
  }
}
