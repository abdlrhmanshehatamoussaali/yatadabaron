import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopic.dart';
import 'package:yatadabaron_flutter/pl/HubPage/TopicCommentsPage.dart';
import 'package:yatadabaron_flutter/pl/HubPage/TopicsPage.dart';

class SearchForumPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchForumPage();
}

class _SearchForumPage extends State<SearchForumPage> {
  ResearchTopic selectedTopic;

  @override
  Widget build(BuildContext context) {
    if (selectedTopic != null) {
      return TopicCommentsPage(
        this.selectedTopic,
        () {
          setState(() {
            this.selectedTopic = null;
          });
        },
        (){
          setState(() {
            
          });
        }
      );
    } else {
      return TopicsPage((t) {
        setState(() {
          this.selectedTopic = t;
        });
      });
    }
  }
}
