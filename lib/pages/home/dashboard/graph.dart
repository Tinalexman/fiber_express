import 'dart:math';

import 'package:fiber_express/misc/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataGraph extends StatefulWidget {
  const DataGraph({super.key});

  @override
  State<DataGraph> createState() => _DataGraphState();
}

class _DataGraphState extends State<DataGraph> {
  List<BarChartGroupData> barData = [];

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, getData);
  }


  List<BarChartGroupData> getData() {
    bool darkTheme = context.isDark;
    Random random = Random();
    return List.generate(
      12,
          (index) => BarChartGroupData(
        x: (index + 1),
        barRods: [
          BarChartRodData(
            toY: random.nextInt(100).toDouble(),
            fromY: 0,
            width: 12.w,
            color: darkTheme ? secondary : primary,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ],
      ),
    );
  }

  double get maxValue {
    double max = 0.0;
    for(var rod in barData) {
      if(rod.barRods[0].toY >= max) {
        max = rod.barRods[0].toY;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        minY: 0,
        maxY: 100,
        alignment: BarChartAlignment.spaceEvenly,
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: const SideTitles(showTitles: true),
            axisNameSize: 40,
            axisNameWidget: Text(
              "Months",
              style: context.textTheme.bodyMedium,
            ),
          ),
        ),
        gridData: const FlGridData(
          drawHorizontalLine: true,
          drawVerticalLine: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: getData(),
      ),
    );
  }
}
