import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;
import 'package:yatadabaron_flutter/bll/ViewModels/LetterFrequency.dart';

class LettersChart extends StatelessWidget {
  List<LetterFrequency> _frequencies = [];
  LettersChart(this._frequencies);

  @override
  Widget build(BuildContext context) {
    var seriesList = [
      Charts.Series<LetterFrequency, String>(
        id: "letter frequencies",
        domainFn: (LetterFrequency f, _) => f.Letter,
        measureFn: (LetterFrequency f, _) => f.Count,
        data: this._frequencies.where((x) => x.Count > 0).toList(),
      )
    ];

    return Expanded(
      flex: 1,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(3),
          child: Charts.BarChart(
            seriesList,
          ),
        ),
      ),
    );
  }
}
