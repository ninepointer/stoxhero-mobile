import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/stocks/controllers/stocks_controller.dart';
import 'package:stoxhero/src/modules/stocks/widget/portfolio_centre_card_Positions.dart';
import 'package:stoxhero/src/modules/stocks/widget/portfolio_positions_card.dart';

import '../../../../../app/app.dart';

class PortfolioPosition extends StatefulWidget {
  const PortfolioPosition({Key? key}) : super(key: key);

  @override
  State<PortfolioPosition> createState() => _PortfolioPositionState();
}

class _PortfolioPositionState extends State<PortfolioPosition> {
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStockPositionsList();
    controller.getStockHoldingsList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background container with rounded edges
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Color(0xFF1B2937) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
          ),
        ),

        Obx(
          () => CentreCardinPositions(
            invested: FormatHelper.formatNumbers(controller.stockTotalPositionDetails.value.holdingnet.toString(),
                decimal: 2),
            currentvalue: FormatHelper.formatNumbers(controller.stockTotalPositionDetails.value.currentvalue.toString(),
                decimal: 2),
            roiPositions: FormatHelper.formatNumbers(
              controller.stockTotalPositionDetails.value.roi.toString(),
              decimal: 2,
              showSymbol: false,
            ),
            pnlInPosition:
                FormatHelper.formatNumbers(controller.stockTotalPositionDetails.value.pnl.toString(), decimal: 2),
          ),
        ),

        Positioned(
          top: 90, // Adjust the top position as needed
          left: 0,
          right: 0,
          bottom: 0,
          child: Obx(
            () => ListView.builder(
              itemCount: controller.stockPositionsList.length, // Adjust based on your data
              itemBuilder: (context, index) {
                // Access data from the controller's positions list
                var position = controller.stockPositionsList[index];
                //print('position${position.toJson()}');
                if (position != null && position.iId?.isLimit == null) {
                  return PositionsCard(
                    position: position,
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}



// CentreCardPositions(netpl: '3', plInPosition: '4'),
 