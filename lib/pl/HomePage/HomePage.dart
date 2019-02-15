import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/pl/AccountPage/AccountPage.dart';
import 'package:yatadabaron_flutter/pl/HubPage/SearchForumPage.dart';
import 'package:yatadabaron_flutter/pl/LettersPage/LettersPage.dart';
import 'package:yatadabaron_flutter/pl/ReadingPage/ReadPage.dart';
import 'package:yatadabaron_flutter/pl/SearchPage/SearchPage.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin {
  TabController _controller;
  Function _onLogIn;

  List<Widget> pages() {
    return [
      AccountPage(() => this._onLogIn),
      SearchPage(),
      LettersPage(),
      ReadPage(),
      SearchForumPage(),
    ];
  }

  Widget tabBarView() {
    return TabBarView(
      children: pages(),
      controller: _controller,

    );
  }

  Widget tabBar() {
    return Container(
      color: Colors.amber[50],
      child: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.account_circle)),
          Tab(icon: Icon(Icons.search)),
          Tab(icon: Icon(Icons.insert_chart)),
          Tab(icon: Icon(Icons.book)),
          Tab(icon: Icon(Icons.forum)),
        ],
        controller: _controller,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this._onLogIn = () => this.setState(() {});
    this._controller = new TabController(length: pages().length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Utils.getTextDirection(),
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SharedWidgets.titleBox(),
            Expanded(
              flex: 1,
              child: tabBarView(),
            )
          ],
        ),
        bottomNavigationBar: tabBar(),
      ),
    );
  }
}
