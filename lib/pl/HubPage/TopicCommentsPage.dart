import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopic.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/HubPage/TopicCommentsList.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/pl/HubPage/TopicListItem.dart';
import 'package:yatadabaron_flutter/utils/Localization.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class TopicCommentsPage extends StatefulWidget {
  final ResearchTopic selectedTopic;

  const TopicCommentsPage(this.selectedTopic);

  @override
  State<StatefulWidget> createState() => _TopicCommentsPage();
}

class _TopicCommentsPage extends State<TopicCommentsPage> {
  int pageSize = 5;
  int noOfPages;

  @override
  void initState() {
    super.initState();
    refreshTopics();
  }

  void refreshTopics() {
    UnitOfWork uow = UnitOfWork();
    var condition = {"TopicID": widget.selectedTopic.TopicID.toString()};
    uow.ResearchTopicComments.count(condition).then((c) {
      setState(() {
        this.noOfPages = Utils.calculateNumberOfPages(c, pageSize);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var commentsList =
        TopicCommentsList(widget.selectedTopic, pageSize, noOfPages);
    var topicHeader = TopicListItem(widget.selectedTopic, () {});
    var commentsSection = Column(
      children: <Widget>[
        topicHeader,
        Divider(height: 20,),
        Expanded(flex: 1, child: commentsList),
      ],
    );
    var body = Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          child: commentsSection,
        ),
      ),
    );

    return new Scaffold(
      appBar: SharedWidgets.customAppBar(
          Utils.localize(Localization.SEARCH_TOPICS_PAGE)),
      body: body,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
           
        },
        mini: true,
      ),
    );
  }
}
