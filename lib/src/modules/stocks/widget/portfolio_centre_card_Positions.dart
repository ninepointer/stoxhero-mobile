import 'package:flutter/material.dart';
import '../../../core/core.dart';

class CentreCardinPositions extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 70,
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
                      'Invested',
                      style: AppStyles.tsBlackRegular12,
                    ),
                    Text(
                      'Current Value',
                      style: AppStyles.tsBlackRegular12,
                    ),
                    Text(
                      'ROI',
                      style: AppStyles.tsBlackRegular12,
                    ),
                  ],
                ),
                // Right side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      invested,
                      style: AppStyles.tsBlackRegular12.copyWith(
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      currentvalue,
                      style: AppStyles.tsBlackRegular12.copyWith(
                        color: Colors.green,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          pnlInPosition,
                          style: AppStyles.tsBlackRegular12.copyWith(
                            color: pnlInPosition != null
                                ? pnlInPosition.startsWith('-')
                                    ? AppColors.danger
                                    : AppColors.success
                                : AppColors
                                    .success, // Replace AppColors.defaultColor with your desired default color
                          ),
                        ),
                        Text(
                          '($roiPositions%)',
                          style: AppStyles.tsBlackRegular12.copyWith(
                            color: roiPositions != null
                                ? roiPositions.startsWith('-')
                                    ? AppColors.danger
                                    : AppColors.success
                                : AppColors.success,
                          ),
                        ),
                      ],
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
