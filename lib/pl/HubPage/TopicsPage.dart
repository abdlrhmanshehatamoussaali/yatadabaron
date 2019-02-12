import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/HubPage/TopicsList.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/Localization.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class TopicsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopicsPage();
}

class _TopicsPage extends State<TopicsPage> {
  int pageSize = 5;
  int noOfPages;

  @override
  void initState() {
    super.initState();
    refreshTopics();
  }

  void refreshTopics() {
    UnitOfWork uow = UnitOfWork();
    uow.ResearchTopics.count().then((c) {
      setState(() {
        this.noOfPages = Utils.calculateNumberOfPages(c, pageSize);         
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var onclickTopic = (t) {
      setState(() {
        Utils.goTopicComments(context, t);
      });
    };
    var topicsSection = TopicsList(pageSize, onclickTopic, noOfPages);
    var body = Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: topicsSection,
      ),
    );

    return new Scaffold(
      appBar: SharedWidgets.customAppBar(
          Utils.localize(Localization.SEARCH_TOPICS_PAGE)),
      body: body,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          refreshTopics();
        },
      ),
    );
  }
}
