import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/stocks/widget/portfolio_centre_card_holdings.dart';
import 'package:stoxhero/src/modules/stocks/widget/portfolio_holdings_card.dart';
import 'package:get/get.dart';
import '../../../../../app/app.dart';
import '../../../controllers/stocks_controller.dart';

class PortfolioHolding extends StatefulWidget {
  const PortfolioHolding({Key? key}) : super(key: key);

  @override
  State<PortfolioHolding> createState() => _PortfolioHoldingState();
}

class _PortfolioHoldingState extends State<PortfolioHolding> {
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStockHoldingsList();
    controller.getStockPositionsList();
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
          () => CentreCardHoldings(
            invested: FormatHelper.formatNumbers(
                controller.stockTotalHoldingDetails.value.net.toString(),
                decimal: 2),
            currentvalue: FormatHelper.formatNumbers(
                controller.stockTotalHoldingDetails.value.currentvalue
                    .toString(),
                decimal: 2),
            roiHoldings: FormatHelper.formatNumbers(
              controller.stockTotalHoldingDetails.value.roi.toString(),
              decimal: 2,
              showSymbol: false,
            ),
            pnlInHoldings: FormatHelper.formatNumbers(
                controller.stockTotalHoldingDetails.value.pnl.toString(),
                decimal: 2),
          ),
        ),
        // cards ka UI

        Positioned(
          top: 90, // Adjust the top position as needed
          left: 0,
          right: 0,
          bottom: 0,
          child: GetBuilder<StocksTradingController>(
            builder: (controller) {
              return ListView.builder(
                itemCount: controller
                    .stockHoldingsList.length, // Adjust based on your data
                itemBuilder: (context, index) {
                  // Access data from the controller's positions list
                  var holding = controller.stockHoldingsList[index];
                  if (holding != null && holding.iId?.isLimit == null) {
                    return HoldingsCard(
                      holding: holding,
                    );
                  } else {
                    return SizedBox();
                  }

                  // Add more cards as needed
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
