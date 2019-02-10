import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/dal/Models/User.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:yatadabaron_flutter/globals.dart' as globals;

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountPage();
  }
}

class _AccountPage extends State<AccountPage> {
  String email;
  String password;

  Widget logOutForm() {
    var logOutButton = RaisedButton(
      child: Text(Utils.getText(48)),
      onPressed: () {
        setState(() {
          globals.isLoggedIn = false;
          globals.user = null;
        });
      },
      color: Theme.of(context).primaryColor,
    );
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: Utils.getTextDirection(),
          children: <Widget>[
            logOutButton,
          ],
        ),
      ),
    );
  }

  Widget logInForm() {
    var emailTextField = SharedWidgets.formSingleField(Utils.getText(26), (x) {
      setState(() {
        this.email = x;
      });
    });
    var passwordTextField = SharedWidgets.formSingleField(Utils.getText(46), (x) {
      setState(() {
        this.password = x;
      });
    });;
    var logInButton = RaisedButton(
      child: Text(Utils.getText(45)),
      onPressed: () async {
        UnitOfWork uow = new UnitOfWork();
        Utils.showPleaseWait(context);
        User u = await uow.Users.authenticateUser(this.email, this.password);
        Navigator.pop(context);
        if (u == null) {
          showDialog(
              context: context,
              builder: (context) {
                return Utils.simpleDialog(context, Utils.getText(57));
              });
        } else {
          setState(() {
            globals.isLoggedIn = true;
            globals.user = u;
            this.email = null;
            this.password = null;
          });
        }
      },
      color: Theme.of(context).primaryColor,
    );
    var signUpButton = RaisedButton(
      child: Text(Utils.getText(47)),
      onPressed: () {
        Utils.goSignup(context);
      },
      color: Theme.of(context).primaryColor,
    );
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            emailTextField,
            passwordTextField,
            Row(
              textDirection: Utils.getTextDirection(),
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(3),
                  child: logInButton,
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  child: signUpButton,
                ),
              ],
            ),
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
      form = logInForm();
    }

    return Scaffold(
      appBar: SharedWidgets.customAppBar(Utils.getText(58)),
      body: Column(
        children: <Widget>[form],
      ),
    );
  }
}
