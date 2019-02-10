import 'dart:convert';

import 'package:yatadabaron_flutter/dal/Models/Gender.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:http/http.dart' as http;

class GenderRepository {
  Future<List<Gender>> getAll() async {
    //send the API
    var uri = Uri.parse(Utils.apiBaseURL() + "Gender/get.php");
    var response = await http.get(
      uri,
      headers: Utils.apiBasicHeaders(),
    );
    var _response = jsonDecode(response.body);
    var records = _response["records"];
    List<Gender> genders = new List();
    for (var record in records) {
      Gender g = Gender();
      g.GenderID = int.parse(record["GenderID"].toString());
      g.TypeAR = record["TypeAR"];
      g.TypeEN = record["TypeEN"];
      genders.add(g);
    }
    return genders;
  }
}
