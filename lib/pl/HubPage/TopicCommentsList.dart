import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopic.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/HubPage/TopicCommentListItem.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';

class TopicCommentsList extends StatelessWidget {
  final ResearchTopic topic;
  final int pageSize;
  final int subCount;

  const TopicCommentsList(this.topic, this.pageSize, this.subCount);

  _commentsFetcher(int pageNumber) async {
    await Future.delayed(Duration(seconds: 1));
    UnitOfWork uow = UnitOfWork();
    var results = await uow.ResearchTopicComments.getCustom(
      {
        "limit": pageSize.toString(),
        "offset": (pageNumber*pageSize).toString(),
        "TopicID": topic.TopicID.toString(),
      }
    );
    return results;
  }

  _commentsBuilder(List page) {
    var items = page.map((topicComment) {
      return TopicCommentListItem(topicComment);
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context,index){
        var item = items[index];
        var itemVisual = Container(
          padding: EdgeInsets.all(5),
          child: item,
        );
        return Column(
          children: <Widget>[
            itemVisual,
            Divider(color: Colors.grey,)
          ],
        );
      },
      itemCount: items.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    var body;
    if (topic != null) {
      body = SharedWidgets.infiniteList(
          _commentsFetcher, _commentsBuilder, subCount);
    } else {
      body = Align(
        alignment: Alignment.center,
        child: Icon(Icons.rotate_left),
      );
    }

    return body;
  }
}
