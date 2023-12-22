import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/stocks/widget/portfolio_centre_card_positions.dart';
import 'package:stoxhero/src/modules/stocks/widget/portfolio_positions_card.dart';

class PortfolioPosition extends StatefulWidget {
  const PortfolioPosition({Key? key}) : super(key: key);

  @override
  State<PortfolioPosition> createState() => _PortfolioPositionState();
}

class _PortfolioPositionState extends State<PortfolioPosition> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background container with rounded edges
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
          ),
        ),

         CentreCardPositions(netpl: '3', plInPosition: '4',roiPositions: '+0.345(3.01%)',),

        
        Positioned(
            top: 80, // Adjust the top position as needed
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView(
              children: [
                Column(
                  children: [
                   PositionsCard(
                            title: "Reliance Power",
                            averageprice: "₹61.8",
                            percentage: "+0.70 (3.01%)",
                            quantity: "35",
                            ltp: "₹59.20",
                            imagePath: 'assets/images/10Xlogo.jpg',
                          ),
                           PositionsCard(
                            title: "Reliance Power",
                            averageprice: "₹61.8",
                            percentage: "+0.70 (3.01%)",
                            quantity: "35",
                            ltp: "₹59.20",
                            imagePath: 'assets/images/10Xlogo.jpg',
                          ),
                           PositionsCard(
                            title: "Reliance Power",
                            averageprice: "₹61.8",
                            percentage: "+0.70 (3.01%)",
                            quantity: "35",
                            ltp: "₹59.20",
                            imagePath: 'assets/images/10Xlogo.jpg',
                          ),
                           PositionsCard(
                            title: "Reliance Power",
                            averageprice: "₹61.8",
                            percentage: "+0.70 (3.01%)",
                            quantity: "35",
                            ltp: "₹59.20",
                            imagePath: 'assets/images/10Xlogo.jpg',
                          ),
                
                    // Add more cards as needed
                  ],
                ),
              ],
            ),
          ),
        
      ],
    );
  }
}



// CentreCardPositions(netpl: '3', plInPosition: '4'),
 