import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yatadabaron_flutter/dal/Models/ResearchPurpose.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';


class PurposesRepository{
  Future<List<ResearchPurpose>> getAll() async {
    //send the API
    var uri = Uri.parse(Utils.apiBaseURL() + "ResearchPurposes/get.php");
    var response = await http.get(
      uri,
      headers: Utils.apiBasicHeaders(),
    );
    var _response = jsonDecode(response.body);
    var records = _response["records"];
    List<ResearchPurpose> entities = new List();
    for (var record in records) {
      ResearchPurpose e = ResearchPurpose();
      e.PurposeID = int.parse(record["PurposeID"].toString());
      e.NameEN = record["NameEN"];
      e.NameAR = record["NameAR"];
      entities.add(e);
    }
    return entities;
  }
}