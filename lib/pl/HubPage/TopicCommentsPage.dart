import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopic.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/HubPage/TopicCommentsList.dart';
import 'package:yatadabaron_flutter/pl/HubPage/TopicListItem.dart';
import 'package:yatadabaron_flutter/utils/Localization.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:yatadabaron_flutter/globals.dart' as globals;

class TopicCommentsPage extends StatefulWidget {
  final ResearchTopic selectedTopic;
  final Function onCancel;
  final Function onRefresh;
  const TopicCommentsPage(this.selectedTopic, this.onCancel,this.onRefresh);

  @override
  State<StatefulWidget> createState() => _TopicCommentsPage();
}

class _TopicCommentsPage extends State<TopicCommentsPage> {
  int pageSize = 5;
  int noOfPages;
  String comment;

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
    var ifEmptyWidget = Container(
      color: Colors.grey[300],
      child: Align(
        alignment: Alignment.center,
        child: Text(
          Utils.localize(Localization.EMPTY_TOPIC_COMMENTS),
          softWrap: true,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ),
    );
    var commentsList = TopicCommentsList(
        widget.selectedTopic, pageSize, noOfPages, ifEmptyWidget);
    var topicHeader = TopicListItem(widget.selectedTopic, () {}, null, false);
    var onAddPressed = () {
      Utils.goPostComment(context, this.widget.selectedTopic.TopicID,(){
        refreshTopics();
      });
    };
    var options = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: RaisedButton(
            child: Text(
              Utils.localize(Localization.ADD_COMMENT),
            ),
            color: Theme.of(context).primaryColor,
            onPressed: (globals.isLoggedIn) ? onAddPressed : null,
          ),
          padding: EdgeInsets.all(5),
        ),
        Container(
          child: RaisedButton(
            child: Text(Utils.localize(
              Localization.BACK_TO_TOPICS,
            )),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              this.widget.onCancel();
            },
          ),
          padding: EdgeInsets.all(5),
        ),
      ],
    );
    String login =
        (globals.isLoggedIn) ? "" : Utils.localize(Localization.YOU_MUST_LOGIN);
    var body = Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Container(
          child: Column(
            children: <Widget>[
              Directionality(
                  child: topicHeader, textDirection: Utils.getTextDirection()),
              Divider(
                height: 8,
              ),
              //goBackButton,
              Expanded(
                flex: 2,
                child: commentsList,
              ),
              options,
              Text(login,style: TextStyle(color: Colors.red,fontSize: 11),),
            ],
          ),
        ),
      ),
    );

    return body;
  }
}
