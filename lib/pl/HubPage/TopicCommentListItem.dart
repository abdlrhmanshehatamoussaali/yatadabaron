import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yatadabaron_flutter/dal/Models/CustomResearchTopicComment.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class TopicCommentListItem extends StatelessWidget {
  CustomResearchTopicComment topicComment;

  TopicCommentListItem(this.topicComment);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat("dd-MM-yyy").format(topicComment.Date);
    String body = "${topicComment.Body}";
    String userName = topicComment.UserName;
    String countryName = topicComment.CountryNameAR;
    return Directionality(
      textDirection: Utils.getTextDirection(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: ListTile(
          //trailing: Icon(Icons.comment),
          title: Text(
            "${topicComment.CommentID} $userName",
            textDirection: Utils.getTextDirection(),
          ),
          subtitle: Text(
            "$countryName-$date \n $body",
            textDirection: Utils.getTextDirection(),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
