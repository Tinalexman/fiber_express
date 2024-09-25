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
  final List<FlSpot> lineChartData = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getData);
  }

  double get maxValue {
    double max = 0.0;
    for (var spot in lineChartData) {
      if (spot.y >= max) {
        max = spot.y;
      }
    }
    return max + 20;
  }

  void getData() {
    List<Usage> usages = ref.watch(dataUsageProvider);
    List<FlSpot> newData = List.generate(
      usages.length,
      (i) {
        String total = usages[i].total;
        total = total.substring(0, total.indexOf("GiB"));

        double yValue = double.tryParse(total) ?? 0.0;

        return FlSpot(
          i.toDouble(),
          yValue,
        );
      },
    );
    lineChartData.clear();
    lineChartData.addAll(newData);
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
    List<Usage> dataUsage = ref.watch(dataUsageProvider);
    bool darkTheme = context.isDark;

    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 600.w,
          child: lineChartData.isEmpty ? null : LineChart(
            LineChartData(
              minY: 0,
              maxY: maxValue,
              minX: 0,
              maxX: 11,
              clipData: const FlClipData.horizontal(),
              backgroundColor: Colors.transparent,
              gridData: const FlGridData(
                drawHorizontalLine: true,
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(
                show: false,
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 45.w,
                    maxIncluded: false,
                    minIncluded: false,
                  ),
                  axisNameWidget: Text(
                    "Total Data Used (GiB)",
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index == dataUsage.length) return const SizedBox();
                      Usage usage = dataUsage[index];
                      return Text(usage.month.toShortMonth);
                    },
                  ),
                  axisNameSize: 40,
                  axisNameWidget: Text(
                    "Months",
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  color: primary,
                  gradient: LinearGradient(
                    colors: [
                      !darkTheme ? primary : secondary,
                      !darkTheme
                          ? primary.withOpacity(0.6)
                          : secondary.withOpacity(0.6),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  belowBarData: BarAreaData(
                    color: !darkTheme ? primary : secondary,
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        !darkTheme
                            ? primary.withOpacity(0.6)
                            : secondary.withOpacity(0.6),
                        Colors.white
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  shadow: Shadow(
                    color: !darkTheme
                        ? primary.withOpacity(0.6)
                        : secondary.withOpacity(0.6),
                  ),
                  isCurved: true,
                  isStrokeCapRound: true,
                  curveSmoothness: 0.75,
                  spots: lineChartData,
                ),
              ],
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        ),
      ),
    );
  }
}
