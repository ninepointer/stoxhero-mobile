import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../core/core.dart';

class CentreCardHoldings extends StatefulWidget {
  const CentreCardHoldings({
    Key? key,
    required this.roiHoldings,
    required this.pnlInHoldings,
    required this.invested,
    required this.currentvalue,
  }) : super(key: key);

  final String invested;
  final String currentvalue;
  final String roiHoldings;
  final String pnlInHoldings;

  @override
  State<CentreCardHoldings> createState() => _CentreCardHoldingsState();
}

class _CentreCardHoldingsState extends State<CentreCardHoldings> {
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Color(0xFF1B2937) : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Get.isDarkMode ? Color(0xFF151F2B).withOpacity(0.8) : Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Holding P&L',
                      style: AppStyles.tsBlackMedium12.copyWith(color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    Text(
                      'ROI',
                      style: AppStyles.tsBlackMedium12.copyWith(color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    Text(
                      'Invested',
                      style: AppStyles.tsBlackMedium12.copyWith(color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    Text(
                      'Current Value',
                      style: AppStyles.tsBlackMedium12.copyWith(color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ],
                ),
                // Right side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      // FormatHelper.formatNumbers(
                      //     controller.calculateTotalHoldingPnl() as double,
                      //     decimal: 2,
                      //     isNegative: true),
                      controller.calculateTotalHoldingPnl().toStringAsFixed(4),
                      //  (invested == 0)
                      //     ? '₹0.00'
                      //     : FormatHelper.formatNumbers(
                      //         pnlInHoldings,
                      //         decimal: 2,
                      //       ),
                      style: AppStyles.tsBlackMedium12.copyWith(
                        color: widget.pnlInHoldings != null
                            ? widget.pnlInHoldings.startsWith('-')
                                ? AppColors.danger
                                : AppColors.success
                            : AppColors.success,
                      ),
                    ),
                    Text(
                      '${(controller.calculateTotalHoldingInvested() == 0 || controller.calculateTotalHoldingroi() == null) ? '0.00' : widget.roiHoldings}%',
                      style: AppStyles.tsBlackMedium12.copyWith(
                        color: controller.calculateTotalHoldingroi() != null
                            ? controller.calculateTotalHoldingroi().startsWith('-')
                                ? AppColors.danger
                                : AppColors.success
                            : AppColors.success,
                      ),
                    ),
                    Text(
                      controller.calculateTotalHoldingInvested(),
                      style: AppStyles.tsBlackMedium12.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                    Text(
                      controller.calculateTotalHoldingCurrentValue(),
                      style: AppStyles.tsBlackMedium12.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
