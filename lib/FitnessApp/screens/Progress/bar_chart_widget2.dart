import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_titles.dart';
import 'data.dart';

class BarChartWidget2 extends StatelessWidget {
  final double barWidth = 22;
  List<Data> barData;
  double recommended_calorie;

  BarChartWidget2({required this.barData, required this.recommended_calorie});

  @override
  Widget build(BuildContext context) {
    double offset1 = 20 - (recommended_calorie / 1000);
    double per = offset1 / 20;
    double offset = per * 370;
    return Stack(children: [
      BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: 20,
          minY: 0,
          groupsSpace: 12,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            topTitles: BarTitles.getTopBottomTitles(),
            bottomTitles: BarTitles.getTopBottomTitles(),
            leftTitles: BarTitles.getSideTitles(),
            rightTitles: BarTitles.getSideTitles(),
          ),
          rangeAnnotations: RangeAnnotations(
            horizontalRangeAnnotations: [
              HorizontalRangeAnnotation(
                  color: Colors.cyan,
                  y1: (recommended_calorie / 1000 - 0.1),
                  y2: recommended_calorie / 1000)
            ],
          ),
          gridData: FlGridData(
            checkToShowHorizontalLine: (value) => value == 0,
            getDrawingHorizontalLine: (value) {
              if (value == 0) {
                return FlLine(
                  color: const Color(0xff363753),
                  strokeWidth: 3,
                );
              } else {
                return FlLine(
                  color: const Color(0xff2a2747),
                  strokeWidth: 0.8,
                );
              }
            },
          ),
          barGroups: barData
              .map(
                (data) => BarChartGroupData(
                  x: data.id,
                  barRods: [
                    BarChartRodData(
                      y: data.y,
                      width: barWidth,
                      colors: [data.color],
                      borderRadius: data.y > 0
                          ? BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            )
                          : BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
      Positioned(
        child: RotationTransition(
            turns: new AlwaysStoppedAnimation(90 / 360),
            child: Text('Recommended')),
        top: offset,
      )
    ]);
  }
}
