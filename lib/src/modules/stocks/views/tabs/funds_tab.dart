import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class Funds extends StatelessWidget {
  const Funds({Key? key, 
  required this.marginavailable, 
  required this.usedmargin, 
  required this.allocatedmargin, 
  required this.investementamount, 
  required this.returns, 
  required this.unrealisedPL, 
  required this.returnpercentage
  
  });
  
  final String  marginavailable;
  final String  usedmargin;
  final String  allocatedmargin;
  final String  investementamount;
  final String  returns;
  final String  unrealisedPL;
  final String  returnpercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 170,
        width: double.infinity,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0), // Adjust the radius as needed
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(
                    "Margin available",
                    style: AppStyles.tsBlackMedium14,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Used Margin",
                    style: AppStyles.tsBlackMedium14,
                  ),
                     SizedBox(height: 5),
                  Text(
                    "Allocated Margin",
                    style: AppStyles.tsBlackMedium14,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Investement Amount",
                    style: AppStyles.tsBlackMedium14,
                  ),
                   SizedBox(height: 5),
                  Text(
                    "Returns",
                    style: AppStyles.tsBlackMedium14,
                  )
                  ,
                   SizedBox(height: 5),
                  Text(
                    "Unrealised P&L",
                    style: AppStyles.tsBlackMedium14,
                  )
                  ,
                   SizedBox(height: 5),
                  Text(
                    "Return percentage",
                     style: AppStyles.tsBlackMedium14,
                  )
                  
                ],
              ),

              // Right side
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   Text(
                    marginavailable,
                    style: AppStyles.tsGreyRegular12,
                  ),
                  SizedBox(height: 5),
                  Text(
                    usedmargin,
                    style: AppStyles.tsGreyRegular12,
                  ),
                  SizedBox(height: 5),
                  Text(
                   allocatedmargin,
                    style: AppStyles.tsGreyRegular12,
                  ),
                  SizedBox(height: 5),
                  Text(
                    investementamount,
                    style: AppStyles.tsBlackMedium14,
                  ),
                    SizedBox(height: 5),
                  Text(
                    returns,
                    style: AppStyles.tsGreyRegular12,
                  ),
                  SizedBox(height: 5),
                  Text(
                    unrealisedPL,
                    style: AppStyles.tsBlackMedium14,
                  ),
                  SizedBox(height: 5),
                  Text(
                    returnpercentage,
                    style: AppStyles.tsGreyRegular12,
                  ),
                 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
