import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:yatadabaron_flutter/utils/Localization.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class HomePage extends StatelessWidget {
  HomePage();

  Widget _titleBox() {
    return new Container(
      alignment: Alignment.center,
      padding: new EdgeInsets.all(10),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/imgs/home.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        textDirection: Utils.getTextDirection(),
        children: <Widget>[
          _title(),
          _subTitle(),
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      alignment: Alignment.center,
      child: new Text(
        Utils.getText(1),
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(70, 70, 70, 1),
          fontSize: 50.0,
        ),
        textDirection: Utils.getTextDirection(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _subTitle() {
    return Container(
      alignment: Alignment.center,
      child: new Text(
        Utils.getText(2),
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 90, 90, 90),
          fontSize: 9.0,
        ),
        textAlign: TextAlign.center,
        textDirection: Utils.getTextDirection(),
      ),
    );
  }

  Widget _menuItem(BuildContext c, String tag, IconData i, Function f) {
    var item = Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(const Radius.circular(15)),
        color: Theme.of(c).primaryColor,
      ),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Icon(i),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                tag,
                textDirection: Utils.getTextDirection(),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
    return GestureDetector(
      child: item,
      onTap: () {
        f();
      },
    );
  }

  Widget _menuItems(BuildContext c) {
    var linkSearch = _menuItem(c, Utils.getText(40), Icons.search, () {
      Utils.goSearch(c);
    });
    var linkLetters = _menuItem(c, Utils.getText(17), Icons.insert_chart, () {
      Utils.goLetters(c);
    });
    var linkRead = _menuItem(c, Utils.getText(41), Icons.book, () {
      Utils.goRead(c);
    });
    var linkContact = _menuItem(c, Utils.getText(42), Icons.email, () {
      Utils.goContact(c);
    });
    var linkRate = _menuItem(c, Utils.getText(43), Icons.star, () {
      LaunchReview.launch();
    });
    var linkAccount = _menuItem(c, Utils.getText(58), Icons.account_box, () {
      Utils.goAccount(c);
    });
    var linkTopics = _menuItem(c, Utils.localize(Localization.SEARCH_TOPICS_PAGE), Icons.forum, () {
      Utils.goTopics(c);
    });

    return GridView.count(
      padding: EdgeInsets.all(10),
      crossAxisCount: 3,
      mainAxisSpacing: 20,
      crossAxisSpacing: 5,
      children: <Widget>[
        linkSearch,
        linkRead,
        linkAccount,
        linkTopics,
        linkLetters,
        linkContact,
        linkRate,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var body = Column(
      textDirection: Utils.getTextDirection(),
      children: <Widget>[
        _titleBox(),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            child: _menuItems(context),
          ),
        ),
      ],
    );

    return Scaffold(
      body: body,
    );
  }
}

// var button = RaisedButton(
//     child: Text(
//       Utils.getText(3),
//       textDirection: Utils.getTextDirection(),
//     ),
//     onPressed: () async {
//       Utils.goSearch(context);
//     },
//     color: Theme.of(context).primaryColor,
//   );

//   var items = this
//       .chapters
//       .map(
//         (c) => ChapterListItem(c),
//       )
//       .toList();
//   var body = Container(
//     padding: EdgeInsets.all(20),
//     child: Column(
//       textDirection: Utils.getTextDirection(),
//       children: <Widget>[
//         Expanded(
//           flex: 1,
//           child: button,
//         ),
//         Text(" "),
//         Expanded(
//           flex: 9,
//           child: ListView(
//             children: items,
//           ),
//         ),
//       ],
//     ),
//   );

//   var column = Column(
//     textDirection: Utils.getTextDirection(),
//     children: <Widget>[
//       _titleBox(),
//       Expanded(
//         child: body,
//       ),
//     ],
//   );
