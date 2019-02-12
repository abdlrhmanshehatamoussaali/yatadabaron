import 'package:yatadabaron_flutter/utils/ValidationRules.dart';

class UserLoginVM {
  String email;
  String password;

  String emailValidation() => ValidationRules.validateEmail(email);
  String passwordValidation() => ValidationRules.validatePassword(password);

  bool isValid(){
    return (emailValidation() == null) && (passwordValidation() == null);
  }
}
