import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:senat_unit_bv/constants/vote_values.dart';

class VotesBarChart extends StatelessWidget {
  final List<charts.Series<VoteStatisticModel, String>> seriesList;
  final bool animate;

  VotesBarChart(this.seriesList, {required this.animate});

  factory VotesBarChart.withSampleData() {
    return VotesBarChart(
      _createSampleData(),
      animate: false,
    );
  }

  factory VotesBarChart.withData(Map<String, int> votesMap) {
    return VotesBarChart(
      _createData(votesMap),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.BarRendererConfig(
          // To not have any rounded corners, use [NoCornerStrategy]
          // To change the radius of the bars, use [ConstCornerStrategy]
          cornerStrategy: const charts.ConstCornerStrategy(10)),
    );
  }

  static List<charts.Series<VoteStatisticModel, String>> _createSampleData() {
    final data = [
      VoteStatisticModel('DA', 12),
      VoteStatisticModel('ABTINERE', 25),
      VoteStatisticModel('NU', 12),
    ];

    return [
      charts.Series<VoteStatisticModel, String>(
        id: 'Votes',
        colorFn: (model, __) {
          if (model.voteValue == 'DA') {
            return charts.MaterialPalette.green.shadeDefault;
          }

          if (model.voteValue == 'NU') {
            return charts.MaterialPalette.red.shadeDefault;
          }

          return charts.MaterialPalette.black.lighter;
        },
        domainFn: (VoteStatisticModel sales, _) => sales.voteValue,
        measureFn: (VoteStatisticModel sales, _) => sales.count,
        data: data,
      )
    ];
  }

  static List<charts.Series<VoteStatisticModel, String>> _createData(Map<String, int> votesMap) {
    final yes = votesMap[VoteValues.YES] ?? 0;
    final abstain = votesMap[VoteValues.ABSTAIN] ?? 0;
    final no = votesMap[VoteValues.NO] ?? 0;

    final data = [
      VoteStatisticModel('DA($yes)', yes),
      VoteStatisticModel('ABTINERE($abstain)', abstain),
      VoteStatisticModel('NU($no)', no),
    ];

    return [
      charts.Series<VoteStatisticModel, String>(
        id: 'Votes',
        colorFn: (model, __) {
          if (model.voteValue.split("(").elementAt(0) == 'DA') {
            return charts.MaterialPalette.green.shadeDefault;
          }

          if (model.voteValue.split("(").elementAt(0) == 'NU') {
            return charts.MaterialPalette.red.shadeDefault;
          }

          return charts.MaterialPalette.black.lighter;
        },
        domainFn: (VoteStatisticModel sales, _) => sales.voteValue,
        measureFn: (VoteStatisticModel sales, _) => sales.count,
        data: data,
      )
    ];
  }
}

class VoteStatisticModel {
  final String voteValue;
  final int count;

  VoteStatisticModel(this.voteValue, this.count);
}
