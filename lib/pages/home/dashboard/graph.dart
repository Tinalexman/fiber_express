import 'dart:developer';

import 'package:fiber_express/components/usage.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataGraph extends ConsumerStatefulWidget {
  const DataGraph({super.key});

  @override
  ConsumerState<DataGraph> createState() => _DataGraphState();
}

class _DataGraphState extends ConsumerState<DataGraph> {
  final List<BarChartGroupData> barData = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getData);
  }

  double get maxValue {
    double max = 0.0;
    for (var rod in barData) {
      if (rod.barRods[0].toY >= max) {
        max = rod.barRods[0].toY;
      }
    }
    return max;
  }

  void getData() {
    bool darkTheme = context.isDark;
    List<Usage> usages = ref.watch(dataUsageProvider);
    List<BarChartGroupData> newData = List.generate(
      usages.length,
          (i) {
        String total = usages[i].total;
        total = total.substring(0, total.indexOf("GiB"));

        double yValue = double.tryParse(total) ?? 0.0;

        return BarChartGroupData(
          x: (i + 1),
          barRods: [
            BarChartRodData(
              toY: yValue,
              fromY: 0,
              width: 12.w,
              color: darkTheme ? secondary : primary,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ],
        );
      },
    );
    barData.clear();
    barData.addAll(newData);
    setState(() {});
  }

  void shouldRefresh() {
    ref.listen(dataUsageProvider, (previous, next) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    shouldRefresh();

    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maxValue,
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
        barGroups: barData,
      ),
    );
  }
}
