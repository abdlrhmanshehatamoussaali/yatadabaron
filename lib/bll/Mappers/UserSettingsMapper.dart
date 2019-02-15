import 'package:yatadabaron_flutter/bll/ViewModels/UserSettings.dart';

class UserSettingsMapper {
  static const String SEPARATOR1 = ";";
  static const String SEPARATOR2 = ":";

  static String stringify(UserSettings x) {
    List<String> array = [
      "noOfUses$SEPARATOR2${x.noOfUses}",
      "userHasSentMessage$SEPARATOR2${x.userHasSentMessage}",
      "userHasSentQuestionnaire$SEPARATOR2${x.userHasSentQuestionnaire}",
      "userHasRated$SEPARATOR2${x.userHasRated}",
      "userID$SEPARATOR2${x.userID}",
      "userEmail$SEPARATOR2${x.userEmail}",
      "userPassword$SEPARATOR2${x.userPassword}",
      "rememberMe$SEPARATOR2${x.rememberMe}",
    ];

    return array.join(SEPARATOR1);
  }

  static UserSettings toUserSettings(String x) {
    UserSettings u = UserSettings();
    try {
      List<String> args = x.split(SEPARATOR1);
      for (String arg in args) {
        String key = arg.split(SEPARATOR2)[0];
        String value = arg.split(SEPARATOR2)[1];
        if (key == "noOfUses") {
          u.noOfUses = value;
        }
        if (key == "userHasSentMessage") {
          u.userHasSentMessage = value;
        }
        if (key == "userHasSentQuestionnaire") {
          u.userHasSentQuestionnaire = value;
        }
        if (key == "userHasRated") {
          u.userHasRated = value;
        }
        if (key == "userID") {
          u.userID = (value);
        }
        if (key == "userEmail") {
          u.userEmail = (value);
        }
        if (key == "userPassword") {
          u.userPassword = (value);
        }
        if (key == "rememberMe") {
          u.rememberMe = (value);
        }
      }
    } catch (e) {}
    return u;
  }
}
