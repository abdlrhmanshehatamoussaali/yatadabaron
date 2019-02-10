import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/LetterFrequency.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class LettersTable extends StatelessWidget {
  List<LetterFrequency> _frequencies = [];
  LettersTable(this._frequencies);

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontSize: 20,
    );

    return Expanded(
      flex: 1,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: this._frequencies.length,
            itemBuilder: (BuildContext b, int index) {
              LetterFrequency f = _frequencies[index];
              String count = f.Count.toString();
              String letter = f.Letter;
              String text = "$letter : $count";
              return Column(
                textDirection: Utils.getTextDirection(),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text,
                    textDirection: Utils.getTextDirection(),
                    style: textStyle,
                  ),
                  Divider(
                    color: Colors.green[100],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
