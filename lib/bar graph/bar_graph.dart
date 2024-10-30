import 'package:expense_tracker/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount
  });

  @override
  Widget build(BuildContext context) {

    BarData myBarData = BarData(
      sunAmount: sunAmount, 
      monAmount: monAmount, 
      tueAmount: tueAmount, 
      wedAmount: wedAmount, 
      thuAmount: thuAmount, 
      friAmount: friAmount, 
      satAmount: satAmount
    );

    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            )
          )
        ),
        barGroups: myBarData.barData
          .map(
            (data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: Colors.grey[800],
                  width: 25,
                  borderRadius: BorderRadius.circular(3),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    color: Colors.grey[200],
                    toY: maxY,

                  )
                ),
              ]
            ),
          )
          .toList(),
      )
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  Widget text;

  switch (value) {
    case 0:
      text = const Text("Sun", style: style,);
      break;
    case 1:
      text = const Text("Mon", style: style,);
      break;
    case 2:
      text = const Text("Tue", style: style,);
      break;
    case 3:
      text = const Text("Wed", style: style,);
      break;
    case 4:
      text = const Text("Thu", style: style,);
      break;
    case 5:
      text = const Text("Fri", style: style,);
      break;
    case 6:
      text = const Text("Sat", style: style,);
      break;
    default:
      text = const Text("", style: style,);
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}