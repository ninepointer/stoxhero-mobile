import 'package:flutter/material.dart';
import '../../../core/core.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    Key? key,
    required this.invested, 
    required this.profitloss, 
    required this.percentage, 
    required this.currentvalue, 
    required this.availablemargin, 
    required this.marginmoney, 
    required this.marginused, 
    required this.openpositions,
  }) : super(key: key);

  final String invested;
  final String profitloss;
  final String percentage;
  final String currentvalue;
  final String availablemargin;
  final String marginmoney;
  final String marginused;
  final String openpositions;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  final bool _customIcon = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10,),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            child: ExpansionTile(
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              backgroundColor: Colors.white,
              collapsedIconColor: Colors.black,
          //     tilePadding: EdgeInsets.symmetric( horizontal: 10), // Adjust the padding here
              title: const Text("Portfolio Summarry"),
              trailing: Icon(
                _customIcon
                    ? Icons.arrow_drop_down_circle
                    : Icons.arrow_drop_down,
              ),
              children: [
                ListTile(
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  tileColor: Colors.white,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 7),
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // Left side
                     Column( 
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Text(
                          "Net P&L",
                          style: AppStyles.tsBlackMedium16,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Invested",
                          style: AppStyles.tsGreyRegular12,
                        ),
                        Text(
                          widget.invested,   
                          style: AppStyles.tsBlackMedium14,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Total Margin Money",
                          style: AppStyles.tsGreyRegular12,
                        ),
                        Text(
                          widget.marginmoney,   
                          style: AppStyles.tsBlackMedium14,
                        ),
                          SizedBox(height: 5),
                        Text(
                          "Margin Used",
                          style: AppStyles.tsGreyRegular12,
                        ),
                        Text(
                          widget.marginused,   
                          style: AppStyles.tsBlackMedium14,
                        ),
                        
                       
                      ],
                     ),

                       //right side 
                       Column( 
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                        Row(
                          children: [
                            Text(
                             widget.profitloss,
                              style: AppStyles.tsBlackMedium16,
                            ),
                            Text(
                              widget.percentage,
                           style: AppStyles.tsBlackMedium14,
                            ),
                          ],
                        ),
                         SizedBox(height: 5),
                        Text(
                          "Current Value", 
                          style: AppStyles.tsGreyRegular12,
                        ),
                        Text(
                          widget.currentvalue,
                          style: AppStyles.tsBlackMedium14,
                        ),
                      
                        SizedBox(height: 5),
                        Text(
                          "Available Margin",
                          style: AppStyles.tsGreyRegular12,
                        ),
                        Text(
                         widget.availablemargin,   
                          style: AppStyles.tsBlackMedium14,
                        ),
                         SizedBox(height: 5),
                        Text(
                          "Open Positions",
                          style: AppStyles.tsGreyRegular12,
                        ),
                        Text(
                         widget.openpositions,   
                          style: AppStyles.tsBlackMedium14,
                        ),
                        
                      ],
                     ),

                     ],
                    )
                   
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

