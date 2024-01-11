import 'package:flutter/material.dart';
import '../../../core/core.dart';

class CentreCardHoldings extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
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
                      style: AppStyles.tsBlackMedium12,
                    ),
                    Text(
                      'ROI',
                      style: AppStyles.tsBlackMedium12,
                    ),
                    Text(
                      'Invested',
                      style: AppStyles.tsBlackMedium12,
                    ),
                    Text(
                      'Current Value',
                      style: AppStyles.tsBlackMedium12,
                    ),
                  ],
                ),
                // Right side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      pnlInHoldings,
                      //  (invested == 0)
                      //     ? '₹0.00'
                      //     : FormatHelper.formatNumbers(
                      //         pnlInHoldings,
                      //         decimal: 2,
                      //       ),
                      style: AppStyles.tsBlackMedium12.copyWith(
                        color: pnlInHoldings != null
                            ? pnlInHoldings.startsWith('-')
                                ? AppColors.danger
                                : AppColors.success
                            : AppColors.success,
                      ),
                    ),
                    Text(
                      '${(invested == 0 || roiHoldings == null) ? '0.00' : roiHoldings}%',
                      style: AppStyles.tsBlackMedium12.copyWith(
                        color: roiHoldings != null
                            ? roiHoldings.startsWith('-')
                                ? AppColors.danger
                                : AppColors.success
                            : AppColors.success,
                      ),
                    ),
                    Text(
                      invested,
                      style: AppStyles.tsBlackMedium12.copyWith(
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      currentvalue,
                      style: AppStyles.tsBlackMedium12.copyWith(
                        color: Colors.green,
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