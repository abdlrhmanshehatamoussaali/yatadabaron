import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/dal/Models/Country.dart';
import 'package:yatadabaron_flutter/dal/Models/Gender.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchPurpose.dart';
import 'package:yatadabaron_flutter/dal/Models/User.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/Shared/CustomDropDown.dart';
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
  String countryKeyword;
  List<Country> countiresTotal;
  List<Country> countires;
  List<Gender> genders;
  List<ResearchPurpose> pruposes;

  @override
  void initState() {
    super.initState();
    UnitOfWork uow = UnitOfWork();
    uow.Countries.fetch().then((e) {
      setState(() {
        this.countiresTotal = e;
        this.countires = new List<Country>();
        this.countires.addAll(e.cast<Country>());
      });
    });
    uow.Genders.fetch().then((e) {
      setState(() {
        this.genders = e;
      });
    });
    uow.Purposes.fetch().then((e) {
      setState(() {
        this.pruposes = e;
      });
    });
  }

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

  void onCountryKeywordChanged(x) {
    var filtered =
        this.countiresTotal.where((c) => c.NameAR.contains(x)).toList();
    setState(() {
      this.countryKeyword = x;
      if (filtered != null && (filtered.length > 0)) {
        this.countires = filtered;
        this._user.CountryID = filtered[0].CountryID;
      }
    });
  }

  Widget signupForm() {
    Widget nameField = SharedWidgets.formSingleField(
      Utils.getText(28),
      (x) {
        setState(() {
          this._user.Name = x;
        });
      },
      error: this._user.nameValidation(),
    );
    Widget emailField = SharedWidgets.formSingleField(
      Utils.getText(26),
      (x) {
        setState(() {
          this._user.Email = x;
        });
      },
      error: _user.emailvalidation(),
    );
    Widget passwordField = SharedWidgets.formSingleField(
      Utils.getText(46),
      (x) {
        setState(() {
          this._user.Password = x;
        });
      },
      error: _user.passwordValidation(),
    );
    Widget ageField = SharedWidgets.formSingleField(
      Utils.getText(50),
      (x) {
        setState(() {
          this._user.Age = Utils.toNumber(x, 0);
        });
      },
      error: _user.ageValidation(),
      type: TextInputType.number,
    );
    Widget countryKeywordField = SharedWidgets.formSingleField(
        Utils.getText(59), onCountryKeywordChanged,
        withLabel: false, withHint: true);

    Widget genderDropDown = CustomDropdown(
      this.genders,
      this._user.GenderID,
      (e) {
        return e.GenderID;
      },
      (e) {
        return e.TypeAR;
      },
      onGenderChanged,
      isExpanded: true,
      error: this._user.genderValidation(),
    );
    Widget countriesDropDown = CustomDropdown(
      this.countires,
      this._user.CountryID,
      (e) {
        return e.CountryID;
      },
      (e) {
        return e.NameAR;
      },
      onCountryChanged,
      isExpanded: true,
      error: this._user.countryValidation(),
    );
    Widget purposesDropDown = CustomDropdown(
      this.pruposes,
      this._user.PurposeID,
      (e) {
        return e.PurposeID;
      },
      (e) {
        return e.NameAR;
      },
      onPurposeChanged,
      isExpanded: true,
      error: this._user.purposeValidation(),
    );

    Widget countryComposite = Column(children: <Widget>[
      countryKeywordField,
      countriesDropDown,
    ]);

    Widget genderField =
        SharedWidgets.formMultipleField(Utils.getText(51), genderDropDown);
    Widget purposeField =
        SharedWidgets.formMultipleField(Utils.getText(53), purposesDropDown);
    Widget countryField =
        SharedWidgets.formMultipleField(Utils.getText(52), countryComposite);

    var signUpButtonOnPressed = () async {
      UnitOfWork uow = UnitOfWork();
      Utils.showPleaseWait(context);
      bool done = await uow.Users.add(this._user);
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
    };
    var signUpButton = RaisedButton(
      child: Text(Utils.getText(47)),
      onPressed: this._user.isvalid() ? signUpButtonOnPressed : null,
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
    var userHint = Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          Utils.getText(60),
          textDirection: Utils.getTextDirection(),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return ListView(
      children: <Widget>[
        emailField,
        passwordField,
        nameField,
        ageField,
        countryField,
        genderField,
        purposeField,
        userHint,
        buttons,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidgets.customAppBar(Utils.getText(47)),
      body: Container(
        padding: EdgeInsets.all(10),
        child: signupForm(),
      ),
    );
  }
}
