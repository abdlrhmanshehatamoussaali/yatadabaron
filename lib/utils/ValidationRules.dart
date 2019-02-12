import 'package:yatadabaron_flutter/utils/utils.dart';

class ValidationRules {
  static String validateNotNull(String s) {
    if (s == null || (s == "")) {
      return validationMessages("EMPTY_FIELD");
    }
    return null;
  }

  static String validateNonZero(int s) {
    if ((s == null) || s == 0) {
      return validationMessages("EMPTY_FIELD");
    }
    return null;
  }

  static String validatePassword(String s) {
    if (s == null || (s == "")) {
      return validationMessages("EMPTY_FIELD");
    }
    if (s.length < 8) {
      return validationMessages("SHORT_PASSWORD");
    }
    return null;
  }

  static String validateEmail(String email) {
    bool isNull = ((email == null) || (email == ""));
    if (isNull) {
      return ValidationRules.validationMessages("EMPTY_FIELD");
    }

    bool isNotEmail = !isEmail(email);
    if (isNotEmail) {
      return ValidationRules.validationMessages("INVALID_EMAIL");
    }
    return null;
  }

  static bool isEmail(String em) {
    String p =r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  static String validateArabicName(String name) {
    bool lengthNotValid = name.length<3;
    bool charactersNotValid = name.contains(new RegExp(r'[\.\-_@;:~`\%!\\\/*-+#$=^&*\(\)\<\>\[\]]+'));
    bool containsNumbers = name.contains(new RegExp(r'[0-9]'));
    if (lengthNotValid || charactersNotValid || containsNumbers) {
      return ValidationRules.validationMessages("INVALID_NAME");
    }
    
    return null;
  }

  static String validationMessages(String key) {
    var dictAR = new Map<String, String>();
    dictAR["EMPTY_FIELD"] = "مطلوب";
    dictAR["INVALID_EMAIL"] = "بريد الكتروني غير صالح ! تأكد من عدم وجود مسافات فارغة.";
    dictAR["SHORT_PASSWORD"] = "كلمة مرور أقل من 8 حروف";
    dictAR["INVALID_AGE"] = "العمر الزمني يجب أن يكون بين 10 إلي 100 سنة";
    dictAR["INVALID_NAME"] = "اختر إسماً حقيقاً ليميزك في ساحة البحث بدون أي رموز أو أرقام وأكثر من 3 حروف";

    var dictEN = new Map<String, String>();
    dictEN["EMPTY_FIELD"] = "Required";
    dictEN["INVALID_EMAIL"] = "Invalid Email!";
    dictEN["SHORT_PASSWORD"] = "Password must be longer than 8 characters";
    dictEN["INVALID_AGE"] = "Age must be within 10 and 100 Years";
    dictEN["INVALID_NAME"] = "Please select suitable name";

    Map<String, String> dict;
    //Localization logic goes here
    if (true) {
      dict = dictAR;
    } else {
      dict = dictEN;
    }
    return dict[key];
  }
}
