import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/UserLoginVM.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/UserSettings.dart';
import 'package:yatadabaron_flutter/pl/AccountPage/AccountSummary.dart';
import 'package:yatadabaron_flutter/pl/Shared/LoginForm.dart';
import 'package:yatadabaron_flutter/utils/Localization.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:yatadabaron_flutter/globals.dart' as globals;

class AccountPage extends StatefulWidget {
  final Function onLogIn;

  const AccountPage(this.onLogIn);

  
  @override
  State<StatefulWidget> createState() {
    return _AccountPage();
  }
}

class _AccountPage extends State<AccountPage> {
  UserLoginVM loginVM = new UserLoginVM();
  bool rememberMe = false;
  Widget logOutForm() {
    var logOutButton = RaisedButton(
      child: Text(Utils.localize(Localization.LOG_OUT)),
      onPressed: () async{
        setState(() {
          globals.isLoggedIn = false;
          globals.user = null;
        });
        //Update the user settings
        await Utils.setRememberMeSettings(0, "", "");
      },
      color: Theme.of(context).primaryColor,
    );
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            AccountSummary(),
            Row(
              textDirection: Utils.getTextDirection(),
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                      child: logOutButton, padding: EdgeInsets.all(15)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget form;
    if (globals.isLoggedIn) {
      form = logOutForm();
    } else {
      form = LoginForm(widget.onLogIn());
    }

    return form;
  }
}
