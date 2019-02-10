import 'package:yatadabaron_flutter/bll/ViewModels/UserSettings.dart';

class UserSettingsMapper{

  
  static const String SEPARATOR1 = ";";
  static const String SEPARATOR2 = ":";
  
  
  static String stringify(UserSettings x) {
    List<String> array = [
      "noOfUses$SEPARATOR2${x.noOfUses}",
      "userHasSentMessage$SEPARATOR2${x.userHasSentMessage}",
      "userHasSentQuestionnaire$SEPARATOR2${x.userHasSentQuestionnaire}",
      "userHasRated$SEPARATOR2${x.userHasRated}",
      "userID$SEPARATOR2${x.userID}",
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
      }
    } catch (e) {}
    return u;
  }

}