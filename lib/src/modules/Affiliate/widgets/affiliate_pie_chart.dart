import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

class AffiliatePieChart extends StatefulWidget {
  final String title;

  const AffiliatePieChart({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<AffiliatePieChart> createState() => _AffiliatePieChartState();
}

class _AffiliatePieChartState extends State<AffiliatePieChart> {
  late AffiliateController controller;

  @override
  void initState() {
    controller = Get.find<AffiliateController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTile(label: widget.title),
        AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PieChart(
              PieChartData(
                sections: getSections(), // Pass your data here
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                borderData: FlBorderData(show: false),
                // sectionsBorderColor: const Color(0xff37434d),
                centerSpaceColor: Colors.white,
                startDegreeOffset: 180,
                // centerSpaceGradient: LinearGradient(
                //   colors: [Colors.blue, Colors.green], // Change as needed
                // stops: [0.5, 0.9],
                //),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> getSections() {
    return List.generate(
      3, // Replace with the number of sections you want
      (index) {
        final isTouched = index == 0; // Highlight the first section if needed
        final double fontSize = isTouched ? 18 : 16;
        final double radius = isTouched ? 60 : 50;

        return PieChartSectionData(
          color: getColor(index), // Choose a color for the section
          value: 40, // Replace with your actual data
          title: '40%', // Replace with your actual data
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        );
      },
    );
  }

  Color getColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
