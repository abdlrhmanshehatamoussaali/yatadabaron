import 'dart:convert';

import 'package:yatadabaron_flutter/dal/Models/Country.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:http/http.dart' as http;

class CountriesRepository {
  Future<List<Country>> getAll() async {
    //send the API
    var uri = Uri.parse(Utils.apiBaseURL() + "Countries/get.php");
    var response = await http.get(
      uri,
      headers: Utils.apiBasicHeaders(),
    );
    var _response = jsonDecode(response.body);
    var records = _response["records"];
    List<Country> entities = new List();
    for (var record in records) {
      Country e = Country();
      e.CountryID = int.parse(record["CountryID"].toString());
      e.NameEN = record["NameEN"];
      e.NameAR = record["NameAR"];
      entities.add(e);
    }
    return entities;
  }
}
