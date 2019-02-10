import 'dart:convert';

import 'package:yatadabaron_flutter/dal/Models/User.dart';
import 'package:http/http.dart' as http;
import 'package:yatadabaron_flutter/utils/utils.dart';

class UsersRepository {
  Future<List<User>> getUserByID(int id) async {
    return null;
  }

  Future<User> authenticateUser(String email, String password) async {
    var uri = Uri.parse(
        "http://www.wisebaysolutions.tech/api/yatadabaron/Users/authenticate.php");
    Map<String, String> body = Map<String, String>();
    body["Email"] = email;
    body["Password"] = password;
    var response = await http.post(
      uri,
      body: json.encode(body),
      headers: Utils.apiBasicHeaders(),
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode == 200) {
      if (response.body == "0") {
        return null;
      } else {
        var jsonUser = jsonDecode(response.body);
        User user = new User();
        user.Name = jsonUser["Name"];
        user.Email = jsonUser["Email"];
        user.Password = jsonUser["Password"];
        user.UserID = int.parse(jsonUser["UserID"]);
        user.CountryID = int.parse(jsonUser["CountryID"]);
        user.GenderID =   int.parse(jsonUser["GenderID"]  );
        user.PurposeID =  int.parse(jsonUser["PurposeID"] );
        user.Age = int.parse(jsonUser["Age"]);
        return user;
      }
    } else {
      return null;
    }
  }

  Future<bool> addUser(User user) async {
    var uri = Uri.parse(
        "http://www.wisebaysolutions.tech/api/yatadabaron/Users/post.php");
    Map<String, String> body = Map<String, String>();
    body["Email"] = user.Email;
    body["Password"] = user.Password;
    body["Age"] = user.Age.toString();
    body["Name"] = user.Name;
    body["CountryID"] = user.CountryID.toString();
    body["GenderID"] = user.GenderID.toString();
    body["PurposeID"] = user.PurposeID.toString();

    var response = await http.post(
      uri,
      body: json.encode(body),
      headers: Utils.apiBasicHeaders(),
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode == 200) {
      if (response.body == "1") {      
        return true;
      }
    }
    return false;
  }

}
