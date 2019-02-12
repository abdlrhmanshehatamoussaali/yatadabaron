import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopic.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class TopicListItem extends StatelessWidget {
  ResearchTopic topic;
  Function onClick;
  TopicListItem(this.topic, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Utils.getTextDirection(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.amber[100]),
          child: ListTile(
            leading: Icon(Icons.bookmark_border),
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
