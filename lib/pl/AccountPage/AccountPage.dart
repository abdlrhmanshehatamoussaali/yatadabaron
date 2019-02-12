import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/UserLoginVM.dart';
import 'package:yatadabaron_flutter/pl/AccountPage/AccountSummary.dart';
import 'package:yatadabaron_flutter/pl/Shared/LoginForm.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/Localization.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:yatadabaron_flutter/globals.dart' as globals;

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountPage();
  }
}

class _AccountPage extends State<AccountPage> {
  UserLoginVM loginVM = new UserLoginVM();

  Widget logOutForm() {
    var logOutButton = RaisedButton(
      child: Text(Utils.localize(Localization.LOG_OUT)),
      onPressed: () {
        setState(() {
          globals.isLoggedIn = false;
          globals.user = null;
        });
      },
      color: Theme.of(context).primaryColor,
    );
    var goTopicsPageButton = RaisedButton(
      child: Text(Utils.localize(Localization.SEARCH_TOPICS_PAGE)),
      onPressed: () {
        Utils.goTopics(context);
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
                  child: Container(child: goTopicsPageButton,padding: EdgeInsets.all(15)),
                ),
                Expanded(
                  flex: 1,
                  child: Container(child: logOutButton,padding: EdgeInsets.all(15)),
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
      form = LoginForm(() {
        this.setState(() {});
      });
    }

    return Scaffold(
      appBar: SharedWidgets.customAppBar(Utils.getText(58)),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[form],
        ),
      ),
    );
  }
}
