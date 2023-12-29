// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class GroupedBarChartWidget extends StatelessWidget {
//   final List<PricePoint> points;

//   GroupedBarChartWidget({required this.points});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 2,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           BarChartWidget(points: points, barColors: [Colors.red, Colors.blue, Colors.green]),
//           BarChartWidget(points: points, barColors: [Colors.yellow, Colors.orange, Colors.purple]),
//           // Add more BarChartWidget instances for additional groups
//         ],
//       ),
//     );
//   }
// }

// class BarChartWidget extends StatelessWidget {
//   final List<PricePoint> points;
//   final List<Color> barColors;

//   BarChartWidget({required this.points, required this.barColors});

//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         barGroups: _chartGroups(),
//         titlesData: FlTitlesData(
//           leftTitles: SideTitles(
//             showTitles: true,
//             interval: 200, // Set the interval for left titles
//           ),
//           bottomTitles: SideTitles(
//             showTitles: true,
//             getTitles: (double value) {
//               int index = value.toInt();
//               if (index >= 0 && index < points.length) {
//                 return points[index].month;
//               }
//               return '';
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   List<BarChartGroupData> _chartGroups() {
//     return points.asMap().entries.map((entry) {
//       int index = entry.key;
//       PricePoint point = entry.value;

//       return BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(
//             y: point.total,
//             colors: [barColors[0]],
//           ),
//           BarChartRodData(
//             y: point.contest,
//             colors: [barColors[1]],
//           ),
//           BarChartRodData(
//             y: point.tenx,
//             colors: [barColors[2]],
//           ),
//         ],
//       );
//     }).toList();
//   }
// }

// class PricePoint {
//   final String month;
//   final double total;
//   final double contest;
//   final double tenx;

//   PricePoint({required this.month, required this.total, required this.contest, required this.tenx});
// }
