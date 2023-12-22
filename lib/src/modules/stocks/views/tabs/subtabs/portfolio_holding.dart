import 'package:flutter/material.dart';
import 'package:stoxhero/src/modules/stocks/widget/portfolio_centre_card_holdings.dart';
import 'package:stoxhero/src/modules/stocks/widget/portfolio_holdings_card.dart';

class PortfolioHolding extends StatefulWidget {
  const PortfolioHolding({Key? key}) : super(key: key);

  @override
  State<PortfolioHolding> createState() => _PortfolioHoldingState();
}

class _PortfolioHoldingState extends State<PortfolioHolding> {
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

        CentreCardHoldings(
          netpl: '3', 
          plInHoldings: '400,00,000',
          roiHoldings:'+0.345(3.01%)'),
        // cards ka UI

        
        Positioned(
            top: 80, // Adjust the top position as needed
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView(
              children: [
                Column(
                  children: [
                    HoldingsCard(
                      title: "Reliance Power",
                      invested: "₹23.95",
                      percentage: "+0.70 (3.01%)",
                      shares: "35",
                      currentvalue: "₹123.9",
                      imagePath: 'assets/images/10Xlogo.jpg',
                    ),
                    HoldingsCard(
                      title: "Reliance Power",
                      invested: "₹23.95",
                      percentage: "+0.70 (3.01%)",
                      shares: "35",
                      currentvalue: "₹123.9",
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
