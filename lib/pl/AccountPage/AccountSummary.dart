import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/globals.dart' as globals;
import 'package:yatadabaron_flutter/utils/Localization.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class AccountSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var email = SharedWidgets.staticLabel(
    //   Utils.localize(Localization.EMAIL ),
    //   (globals.user.Email),
    // );
    var email = Text( globals.user.Email);
    var name = SharedWidgets.staticLabel(
      Utils.localize(Localization.NAME),
      (globals.user.Name),
    );
    var age = SharedWidgets.staticLabel(
      Utils.localize(Localization.AGE),
      (globals.user.Age.toString()),
    );
    var countryName = SharedWidgets.staticLabel(
      Utils.localize(Localization.COUNTRY),
      (globals.user.MyCountry.NameAR.toString()),
    );
    var gender = SharedWidgets.staticLabel(
      Utils.localize(Localization.GENDER),
      (globals.user.MyGender.TypeAR.toString()),
    );
    var purpose = SharedWidgets.staticLabel(
      Utils.localize(Localization.PURPOSE),
      (globals.user.MyPurpose.NameAR.toString()),
    );

    var divider = Divider(
      color: Colors.grey,
    );

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          divider,
          email,
          divider,
          name,
          divider,
          age,
          divider,
          countryName,
          divider,
          gender,
          divider,
          purpose,
          divider
        ],
      ),
    );
  }
}
