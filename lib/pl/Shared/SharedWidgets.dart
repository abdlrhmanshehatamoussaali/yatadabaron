import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/VerseGenericVM.dart';
import 'package:yatadabaron_flutter/globals.dart' as globals;

class SharedWidgets {
  static Widget formMultipleField(String name, Widget item) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Row(
        textDirection: Utils.getTextDirection(),
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              name,
              textDirection: Utils.getTextDirection(),
            ),
          ),
          Expanded(
            flex: 2,
            child: item,
          )
        ],
      ),
    );
  }

  static Widget formSingleField(String name, Function _onChanged,[TextInputType type=TextInputType.text]) {
    var decoration = InputDecoration(
      labelText: name,
      isDense: true,
      hintText: name
    );
    var style = TextStyle(
      height: 1,
      color: Colors.black,
    );
    var textField = TextField(
      keyboardType: type,
      textDirection: Utils.getTextDirection(),
      style: style,
      decoration: decoration,
      onChanged: (x) {
        _onChanged(x);
      },
      maxLines: 1,
      textAlign: TextAlign.center,
    );

    return Directionality(
      child: textField,
      textDirection: Utils.getTextDirection(),
    );
  }
 
  static Widget userAvatar() {
    if (globals.isLoggedIn) {
      return Row(
        textDirection: Utils.getTextDirection(),
        children: <Widget>[
          Icon(Icons.account_circle),
          Text(
            globals.user.Name,
            style: TextStyle(
              color: Colors.orange[400],
              fontStyle: FontStyle.italic
            ),
          ),
        ],
      );
    } else {
      return Row(
        textDirection: Utils.getTextDirection(),
        children: <Widget>[
          Icon(Icons.account_circle),
          Text(Utils.getText(44)),
        ],
      );
    }
  }

  static Widget customAppBar(String title, [bool backArrow = true]) {
    var body = Container(
      padding: EdgeInsets.all(3),
      child: Row(
        textDirection: Utils.getTextDirection(),
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: Utils.getTextDirection(),
              children: <Widget>[
                Text(
                  title,
                  textDirection: Utils.getTextDirection(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                userAvatar()
              ],
            ),
          )
        ],
      ),
    );
    if (!backArrow) {
      return AppBar(
        leading: new Container(),
        flexibleSpace: body,
      );
    }
    return AppBar(
      flexibleSpace: body,
    );
  }

  static Widget searchResults(List<VerseGenericVM> verses,
      [bool header = false]) {
    if (verses == null) {
      return Text("");
    }
    var results = verses.map((v) {
      List<Widget> _widgets = [];
      if (header) {
        var _widgetHeader = RichText(
          text: TextSpan(children: [
            TextSpan(
              text: v.header,
              style: TextStyle(
                  fontFamily: 'Usmani',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            )
          ]),
          textAlign: TextAlign.center,
          textDirection: Utils.getTextDirection(),
        );
        _widgets.add(_widgetHeader);
      }

      var _widgetBody = RichText(
        text: TextSpan(children: [
          TextSpan(
            text: v.body,
            style: TextStyle(
                fontFamily: 'Usmani', fontSize: 20, color: Colors.black),
          ),
          TextSpan(
            text: "  {${v.index.toString()}}",
            style: TextStyle(
                fontFamily: 'Usmani', fontSize: 20, color: Colors.black),
          )
        ]),
        textAlign: TextAlign.center,
        textDirection: Utils.getTextDirection(),
      );

      var _divider = Divider(
        color: Colors.green[100],
      );
      _widgets.add(_widgetBody);
      _widgets.add(_divider);
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          textDirection: Utils.getTextDirection(),
          children: _widgets,
        ),
      );
    }).toList();

    return Expanded(
      flex: 1,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: results,
          ),
        ),
      ),
    );
  }
}
