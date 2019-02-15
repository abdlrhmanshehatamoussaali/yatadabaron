import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yatadabaron_flutter/dal/Models/CustomResearchTopicComment.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class TopicCommentListItem extends StatelessWidget {
  CustomResearchTopicComment topicComment;
  Color color;
  TopicCommentListItem(this.topicComment,[this.color]);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat("dd-MM-yyy").format(topicComment.Date);
    String body = "${topicComment.Body}";
    String userName = topicComment.UserName;
    String countryName = topicComment.CountryNameAR;
    String countryDate = "$countryName : $date";
    
    var infoStyle = TextStyle(
      color: Colors.grey,
      fontSize: 11
    );
    var nameStyle = TextStyle(
      //color: Colors.grey,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
    var bodyStyle = TextStyle(
      //color: Colors.grey,
      fontSize: 14,
      fontFamily: 'Verdana'
    );
    var textName = Text(
      userName,
      textDirection: Utils.getTextDirection(),
      textAlign: TextAlign.start,
      style: nameStyle,
    );
    var textBody = Text(
      body,
      textDirection: Utils.getTextDirection(),
      textAlign: TextAlign.start,
      style: bodyStyle,
    );
    var textInfo = Text(
      countryDate,
      textDirection: Utils.getTextDirection(),
      textAlign: TextAlign.start,
      style: infoStyle,
    );
    //var _color = color??Colors.amber[50];
    return Directionality(
      textDirection: Utils.getTextDirection(),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          title: Column(
            textDirection: Utils.getTextDirection(),
            children: <Widget>[
              Row(children:[textName] ,),
              Row(children:[textInfo] ,),
              Row(children:[textBody] ,),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
