import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/dal/Models/User.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/Shared/ChaptersDropDown.dart';
import 'package:yatadabaron_flutter/pl/Shared/CountriesDropDown.dart';
import 'package:yatadabaron_flutter/pl/Shared/GenderDropDown.dart';
import 'package:yatadabaron_flutter/pl/Shared/PurposesDropDown.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:yatadabaron_flutter/globals.dart' as globals;

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupPage();
  }
}

class _SignupPage extends State<SignupPage> {
  User _user = User();
 
  
  void onGenderChanged(id) {
    setState(() {
      this._user.GenderID = id;
    });
  }

  void onCountryChanged(id) {
    setState(() {
      this._user.CountryID = id;
    });
  }

  void onPurposeChanged(id) {
    setState(() {
      this._user.PurposeID = id;
    });
  }

  Widget signupForm() {
    Widget nameField = SharedWidgets.formSingleField(Utils.getText(28), (x) {
      setState(() {
        this._user.Name = x;
      });
    });
    Widget emailField = SharedWidgets.formSingleField(Utils.getText(26), (x) {
      setState(() {
        this._user.Email = x;
      });
    });
    Widget passwordField = SharedWidgets.formSingleField(Utils.getText(46), (x) {
      setState(() {
        this._user.Password = x;
      });
    });
    Widget ageField = SharedWidgets.formSingleField(Utils.getText(50), (x) {
      setState(() {
        this._user.Age = int.parse(x.toString());
      });
    });
    Widget countriesDropDown =
        CountriesDropdown(this._user.CountryID, onCountryChanged, () {}, true);
    Widget genderDropDown =
        GenderDropdown(this._user.GenderID, onGenderChanged, () {}, true);
    Widget purposesDropDown =
        PurposesDropdown(this._user.PurposeID, onPurposeChanged, () {}, true);
    Widget countryField = SharedWidgets.formMultipleField(Utils.getText(52), countriesDropDown);
    Widget purposeField = SharedWidgets.formMultipleField(Utils.getText(53), purposesDropDown);
    Widget genderField = SharedWidgets.formMultipleField(Utils.getText(51), genderDropDown);

    var signUpButton = RaisedButton(
      child: Text(Utils.getText(47)),
      onPressed: () async {
        UnitOfWork uow = UnitOfWork();
        Utils.showPleaseWait(context);
        bool done = await uow.Users.addUser(this._user);
        Navigator.pop(context);
        if (done) {
          await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return Utils.simpleDialog(context, Utils.getText(54));
            },
          );
          Utils.goHome(context);
        } else {
          await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return Utils.simpleDialog(context, Utils.getText(55));
            },
          );
        }
      },
      color: Theme.of(context).primaryColor,
    );
    var backButton = RaisedButton(
      child: Text(Utils.getText(49)),
      onPressed: () {
        Utils.goHome(context);
      },
      color: Theme.of(context).primaryColor,
    );
    var buttons = Row(
      textDirection: Utils.getTextDirection(),
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(3),
          child: signUpButton,
        ),
        Container(
          padding: EdgeInsets.all(3),
          child: backButton,
        ),
      ],
    );

    return ListView(
      children: <Widget>[
        emailField,
        passwordField,
        nameField,
        ageField,
        genderField,
        countryField,
        purposeField,
        buttons,
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidgets.customAppBar(Utils.getText(47), false),
      body: Container(
        padding: EdgeInsets.all(10),
        child: signupForm(),
      ),
    );
  }
}
