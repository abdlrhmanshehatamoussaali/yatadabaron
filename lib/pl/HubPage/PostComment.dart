import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopicComment.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/utils/Localization.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import 'package:yatadabaron_flutter/globals.dart' as globals;

class PostComment extends StatefulWidget {
  final int topicID;
  final Function onAdd;

  const PostComment(this.topicID, this.onAdd);

  @override
  State<StatefulWidget> createState() => _PostComment();
}

class _PostComment extends State<PostComment> {
  String comment;

  Widget postDialog() {
    var decoration = InputDecoration(
      labelText: Utils.localize(Localization.WRITE_COMMENT_HERE),
      hintText: Utils.localize(Localization.WRITE_COMMENT_HERE),
      border: OutlineInputBorder(),
      errorText: (globals.isLoggedIn
          ? null
          : Utils.localize(Localization.YOU_MUST_LOGIN)),
    );
    var style = TextStyle(fontSize: 14, color: Colors.black);
    var field = TextField(
      decoration: decoration,
      style: style,
      onChanged: (x) {
        this.setState(() {
         this.comment = x; 
        });
      },
      maxLines: 10,
    );
    return Directionality(
      child: field,
      textDirection: Utils.getTextDirection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var onPost = () async {
       UnitOfWork uow = UnitOfWork();
        ResearchTopicComment comment = new ResearchTopicComment();
        bool done = false;
        if (globals.isLoggedIn && globals.user != null) {
          comment.UserID = globals.user.UserID;
          comment.Body = this.comment;
          comment.TopicID = this.widget.topicID;
          Utils.showPleaseWait(this.context);
          done = await uow.ResearchTopicComments.add(comment);
        }
        Navigator.pop(context);
        String msg = Utils.localize(Localization.POST_COMMENT_FAIL);
        if (done) {
          msg = Utils.localize(Localization.POST_COMMENT_SUCCESS);
        }
        await showDialog(
            context: context,
            builder: (c) {
              return Utils.simpleDialog(context, msg);
            });
        Navigator.pop(context);
        widget.onAdd();
    };
    var shouldPost = globals.isLoggedIn && (this.comment != null) && (this.comment != "");
    return new Scaffold(
      appBar:
          SharedWidgets.customAppBar(Utils.localize(Localization.ADD_COMMENT)),
      body: Column(
        children: <Widget>[
          Container(
            child: postDialog(),
            padding: EdgeInsets.all(10),
          ),
          RaisedButton(
            child: Text(Utils.localize(Localization.ADD_COMMENT)),
            onPressed: shouldPost?onPost:null,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
