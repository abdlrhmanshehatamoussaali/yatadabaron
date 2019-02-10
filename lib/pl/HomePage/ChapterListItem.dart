import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/ChapterVM.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';
import '../SearchPage/SearchPage.dart';

class ChapterListItem extends StatelessWidget {
  ChapterVM _chapter;

  ChapterListItem(this._chapter);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Container(
          child: Row(
            textDirection: Utils.getTextDirection(),
            children: <Widget>[
              Column(
                textDirection: Utils.getTextDirection(),
                children: <Widget>[
                  Text(
                    this._chapter.NameWithNumber,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textDirection: Utils.getTextDirection(),
                  ),
                  Text(
                    (this._chapter.StringifiedLocation +
                        " - " +
                        this._chapter.StringifiedSize),
                    textDirection: Utils.getTextDirection(),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
          ),
          padding: EdgeInsets.all(5),
        ),
      ),
      onTap: () {
       Utils.goSearch(context, this._chapter);
      },
    );
  }
}
