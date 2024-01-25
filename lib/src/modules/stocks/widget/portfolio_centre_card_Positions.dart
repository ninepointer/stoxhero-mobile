import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../../../core/core.dart';

class CentreCardinPositions extends StatefulWidget {
  const CentreCardinPositions({
    Key? key,
    required this.invested,
    required this.currentvalue,
    required this.roiPositions,
    required this.pnlInPosition,
  }) : super(key: key);

  final String invested;
  final String currentvalue;
  final String roiPositions;
  final String pnlInPosition;

  @override
  State<CentreCardinPositions> createState() => _CentreCardinPositionsState();
}

class _CentreCardinPositionsState extends State<CentreCardinPositions> {
  late StocksTradingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<StocksTradingController>();
    controller.getStockPositionsList();
    controller.getStockHoldingsList();
    //controller.calculateTotalPositionValues();
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
              color: Get.isDarkMode
                  ? Color(0xFF151F2B).withOpacity(0.8)
                  : Colors.grey.withOpacity(0.2),
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
                      'Positions P&L',
                      style: AppStyles.tsBlackMedium12.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    Text(
                      'ROI',
                      style: AppStyles.tsBlackMedium12.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    Text(
                      'Invested',
                      style: AppStyles.tsBlackMedium12.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                    Text(
                      'Current Value',
                      style: AppStyles.tsBlackMedium12.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ],
                ),
                // Right side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.pnlInPosition,
                      style: AppStyles.tsBlackMedium12.copyWith(
                        color: widget.pnlInPosition != null
                            ? widget.pnlInPosition.startsWith('-')
                                ? AppColors.danger
                                : AppColors.success
                            : AppColors
                                .success, // Replace AppColors.defaultColor with your desired default color
                      ),
                    ),
                    Text(
                      '${(widget.invested == 0 || widget.roiPositions == null) ? '0.00' : widget.roiPositions}%',
                      style: AppStyles.tsBlackMedium12.copyWith(
                        color: widget.roiPositions != null
                            ? widget.roiPositions.startsWith('-')
                                ? AppColors.danger
                                : AppColors.success
                            : AppColors.success,
                      ),
                    ),
                    Text(
                      widget.invested,
                      style: AppStyles.tsBlackMedium12
                          .copyWith(color: AppColors.success),
                    ),
                    Text(
                      widget.currentvalue,
                      style: AppStyles.tsBlackMedium12
                          .copyWith(color: AppColors.success),
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
