import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

BarChartGroupData makeGroupdata(int x, double y, double width) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: Colors.white,
        width: width,
        borderRadius: BorderRadius.circular(6),
      )
    ],
  );
}
