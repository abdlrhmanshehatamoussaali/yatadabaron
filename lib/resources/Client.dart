import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yatadabaron_flutter/dal/Models/Country.dart';
import 'package:yatadabaron_flutter/dal/Models/CustomResearchTopicComment.dart';
import 'package:yatadabaron_flutter/dal/Models/Gender.dart';
import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchPurpose.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopic.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopicComment.dart';
import 'package:yatadabaron_flutter/dal/Models/User.dart';
import 'package:yatadabaron_flutter/dal/Models/UserMessage.dart';
import 'package:yatadabaron_flutter/dal/Models/UserReply.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class Client {
  static Future<dynamic> post(String endpoint, Map<String, String> body,
      {String customPath: null}) async {
    var uri = Uri.parse(apiBaseURL() + "$endpoint/post.php");
    if (customPath != null) {
      uri = Uri.parse(apiBaseURL() + "$endpoint/$customPath");
    }
    var response = await http.post(
      uri,
      body: json.encode(body),
      headers: apiBasicHeaders(),
      encoding: Encoding.getByName("utf-8"),
    );
    if (response.statusCode == 200) {
      var _response = jsonDecode(response.body);
      return _response;
    }
    return null;
  }

  static Future<dynamic> getResource(String resourcePath,
      [Map<String, String> paramsMap = null]) async {
    var query = "";
    if (paramsMap != null) {
      List<String> queryParams = new List<String>();
      paramsMap.forEach((k, v) {
        queryParams.add("$k=$v");
      });
      query = "?" + queryParams.join("&");
    }
    String fullResourcePath = resourcePath + query;
    var uri = Uri.parse(apiBaseURL() + fullResourcePath);
    var response = await http.get(
      uri,
      headers: apiBasicHeaders(),
    );
    if (response != null && (response.statusCode == 200)) {
      if (response.body != null) {
        var json = jsonDecode(response.body);
        return json;
      }
    }
    return null;
  }

  static Future<int> countEntity<T extends ISerializable>(
      [Map<String, String> paramsMap = null]) async {
    String endpoint = endpointsMap()[T];
    String resourcePath = "$endpoint/count.php";
    var response = await getResource(resourcePath, paramsMap);
    try {
      var c = ((response["records"])[0])["count"];
      return Utils.toNumber(c.toString(), -1);
    } catch (e) {
      print(e);
    }
    return -1;
  }

  static Future<List<T>> getEntity<T extends ISerializable>(
      [Map<String, String> paramsMap = null]) async {
    String endpoint = endpointsMap()[T];
    String resourcePath = "$endpoint/get.php";
    var response = await getResource(resourcePath, paramsMap);
    try {
      List<dynamic> records = response["records"];
      List<T> entities = new List<T>();
      records.forEach((r) {
        entities.add(getInstanceOf(T, r));
      });
      return entities;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Map<Type, String> endpointsMap() {
    Map<Type, String> ret = Map<Type, String>();
    ret[User] = "Users";
    ret[Gender] = "Gender";
    ret[Country] = "Countries";
    ret[ResearchPurpose] = "ResearchPurposes";
    ret[ResearchTopic] = "ResearchTopics";
    ret[ResearchTopicComment] = "ResearchTopicComments";
    ret[UserMessage] = "UserMessages";
    ret[UserReply] = "UserReplies";
    return ret;
  }

  static dynamic getInstanceOf(Type t, dynamic json) {
    switch (t) {
      case User:
        return User().fromJSON(json);
        break;
      case Gender:
        return Gender().fromJSON(json);
        break;
      case Country:
        return Country().fromJSON(json);
        break;
      case ResearchPurpose:
        return ResearchPurpose().fromJSON(json);
        break;
      case ResearchTopic:
        return ResearchTopic().fromJSON(json);
        break;
      case ResearchTopicComment:
        return ResearchTopicComment().fromJSON(json);
        break;
      case UserMessage:
        return UserMessage().fromJSON(json);
        break;
      case UserReply:
        return UserReply().fromJSON(json);
        break;
      default:
        return null;
    }
  }

  static String apiBaseURL() {
    return "http://www.wisebaysolutions.tech/api/yatadabaron/";
  }

  static Map<String, String> apiBasicHeaders() {
    return {
      "Content-Type": "application/json; charset=UTF-8",
      "authorization":
          "Basic " + base64Encode(utf8.encode("abdlrhmanshehata:ilp01bmrIDC!"))
    };
  }
}
