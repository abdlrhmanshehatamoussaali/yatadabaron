import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/UserLoginVM.dart';
import 'package:yatadabaron_flutter/dal/Models/User.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/Localization.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:yatadabaron_flutter/globals.dart' as globals;

class LoginForm extends StatefulWidget {
  final Function refresh;
  LoginForm(this.refresh);
  @override
  State<StatefulWidget> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  UserLoginVM loginVM = new UserLoginVM();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    String emailValidation = loginVM.emailValidation();
    String passwordValidation = loginVM.passwordValidation();
    var emailTextField = SharedWidgets.formSingleField(
      Utils.getText(26),
      (x) {
        setState(() {
          this.loginVM.email = x;
        });
      },
      error: emailValidation,
    );
    var passwordTextField = SharedWidgets.formSingleField(
      Utils.getText(46),
      (x) {
        setState(() {
          this.loginVM.password = x;
        });
      },
      error: passwordValidation,
      isPassword: true,
    );

    var logInOnPressed = () async {
      UnitOfWork uow = new UnitOfWork();
      Utils.showPleaseWait(context);
      User u = await uow.Users.authenticate(
        this.loginVM.email,
        this.loginVM.password,
      );
      Navigator.pop(context);
      if (u == null) {
        showDialog(
            context: context,
            builder: (context) {
              return Utils.simpleDialog(context, Utils.getText(57));
            });
      } else {
        //Update the user settings
        if (rememberMe) {
          var result = await Utils.setRememberMeSettings(
              rememberMe ? 1 : 0, u.Email, u.Password);
        }
        setState(() {
          globals.isLoggedIn = true;
          globals.user = u;
          this.loginVM = new UserLoginVM();
        });
        widget.refresh();
      }
    };

    var logInButton = RaisedButton(
      child: Text(Utils.getText(45)),
      onPressed: loginVM.isValid() ? logInOnPressed : null,
      color: Theme.of(context).primaryColor,
    );
    var signUpButton = RaisedButton(
      child: Text(Utils.getText(47)),
      onPressed: () {
        Utils.goSignup(context);
      },
      color: Theme.of(context).primaryColor,
    );
    var buttonRow = Row(
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
    );
    var checkbox = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          tristate: false,
          onChanged: (x) async {
            setState(() {
              this.rememberMe = x;
            });
          },
          value: rememberMe,
        ),
        Text(Utils.localize(Localization.REMEMBER_ME))
      ],
    );
    var form = ListView(
      children: <Widget>[
        emailTextField,
        passwordTextField,
        buttonRow,
        checkbox
      ],
    );
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: form,
          ),
        ],
      ),
    );
  }
}
