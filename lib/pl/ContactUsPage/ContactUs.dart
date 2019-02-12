import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/ContactForm.dart';
import 'package:yatadabaron_flutter/dal/Models/User.dart';
import 'package:yatadabaron_flutter/dal/Models/UserMessage.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:yatadabaron_flutter/globals.dart' as globals;

class ContactUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactUs();
  }
}

class _ContactUs extends State<ContactUs> {
  ContactForm _myForm = ContactForm();
  UserMessage _message = UserMessage();

  TextStyle _labelsStyle() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  InputDecoration _decoration() {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(10))));
  }

  Widget _form() {
    return ListView(
      children: <Widget>[
        Text(
          Utils.getText(27),
          style: _labelsStyle(),
          textDirection: Utils.getTextDirection(),
        ),
        TextField(
          textDirection: Utils.getTextDirection(),
          decoration: _decoration(),
          maxLines: 8,
          onChanged: (x) {
            setState(() {
              this._myForm.Message = x;
            });
          },
        ),
         Card(
          child: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              Utils.getText(32),
              textAlign: TextAlign.center,
              softWrap: true,
              textDirection: Utils.getTextDirection(),
              style: _labelsStyle(),
            ),
          ),
        ),
        RaisedButton(
          child: Text(Utils.getText(29)),
          onPressed: () async {
            await Utils.sendUserMessage(this._myForm, context);
          },
          color: Theme.of(context).primaryColor,
        ),
       
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidgets.customAppBar(Utils.getText(25)),
      body: Container(
        padding: EdgeInsets.all(10),
        child: _form(),
      ),
    );
  }
}
