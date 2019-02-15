import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopic.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class TopicListItem extends StatelessWidget {
  ResearchTopic topic;
  Function onClick;
  Color color;
  bool withIcon;
  TopicListItem(this.topic, this.onClick, [this.color = null,this.withIcon = true]);

  @override
  Widget build(BuildContext context) {
    var _color = (this.color != null) ? this.color : Colors.amber[50];
    return Directionality(
      textDirection: Utils.getTextDirection(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: _color,
        ),
        child: ListTile(
          leading: withIcon?Icon(Icons.bookmark_border):null,
          title: Text(
            "${topic.Title}",
            textDirection: Utils.getTextDirection(),
          ),
          subtitle: Text(
            DateFormat("dd-MM-yyy").format(topic.Date),
            textDirection: Utils.getTextDirection(),
          ),
          onTap: () {
            this.onClick(topic);
          },
        ),
      ),
    );
  }
}
