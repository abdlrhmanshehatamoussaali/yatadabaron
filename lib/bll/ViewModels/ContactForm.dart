import 'package:yatadabaron_flutter/utils/utils.dart';

class ContactForm {
  String ID;
  String Name = "";
  String Email = "NULL";
  String Message = "";

  ContactForm() {
    Utils.getUserSettings().then((x) {
      this.ID = x.userID;
    });
  }

  bool Valid() {
    return this.Name.isNotEmpty &&
        this.Message.isNotEmpty;
  }
}
