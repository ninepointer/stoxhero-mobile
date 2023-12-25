import 'package:flutter/material.dart';
import '../../../core/core.dart';

class CentreCardPositions extends StatelessWidget {
  const CentreCardPositions({
    Key? key,
    required this.netpl,
    required this.plInPosition,
    required this.roiPositions, 
  
  }) : super(key: key);

  final String netpl;
  final String plInPosition;
  final String roiPositions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        margin: EdgeInsets.only( left: 40, right: 40),
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
            padding: const EdgeInsets.only(top:5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     'Invested',
                      style: AppStyles.tsBlackMedium14,
                    ),
                    Text(
                      'Current Value',
                      style: AppStyles.tsBlackMedium14,
                    ),
                    Text(
                      'ROI',
                      style: AppStyles.tsBlackMedium14,
                    ),
                    
                  ],
                ),
                // Right side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                     "₹$netpl",
                     style: AppStyles.tsBlackMedium14.copyWith(
                      color:  Colors.green ,
                    ),
                    ),
                    Text(
                      "₹$plInPosition",
                     style: AppStyles.tsBlackMedium14.copyWith(
                     color:  Colors.green ,
                    ),
                    ),
                    Text(
                      roiPositions,
                    style: AppStyles.tsBlackMedium14.copyWith(
                     color:  Colors.green ,
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
