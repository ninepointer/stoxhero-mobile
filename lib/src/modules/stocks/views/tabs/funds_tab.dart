import 'package:flutter/material.dart';

class Funds extends StatelessWidget {
  const Funds({
    Key? key,
    required this.marginavailable,
    required this.usedmargin,
    required this.allocatedmargin,
    required this.investmentamount,
    required this.returns,
    required this.unrealisedPL,
    required this.returnpercentage,
  }) : super(key: key);

  final String marginavailable;
  final String usedmargin;
  final String allocatedmargin;
  final String investmentamount;
  final String returns;
  final String unrealisedPL;
  final String returnpercentage;

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
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListView(
          children: [
            FundsCard(
                cardname: "Margin available",
                cardvalue: marginavailable,
                index: 0),
            FundsCard(cardname: "Used margin", cardvalue: usedmargin, index: 1),
            FundsCard(
                cardname: "Allocated margin",
                cardvalue: allocatedmargin,
                index: 2),
            FundsCard(
                cardname: "investmentamount",
                cardvalue: investmentamount,
                index: 3),
            FundsCard(cardname: "returns", cardvalue: returns, index: 4),
            FundsCard(
                cardname: "unrealisedPL", cardvalue: unrealisedPL, index: 5),
            FundsCard(
                cardname: "Return Percentage",
                cardvalue: returnpercentage,
                index: 6),
            // Add more FundsCard widgets as needed
          ],
        ),
      ),
    );
  }
}

class FundsCard extends StatelessWidget {
  const FundsCard({
    Key? key,
    required this.cardname,
    required this.cardvalue,
    required this.index,
  }) : super(key: key);

  final String cardname;
  final String cardvalue;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: index % 2 == 0 ? Colors.white : Colors.grey[200],
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardname,
                  // style: AppStyles.tsBlackRegular16, // Uncomment if needed
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  cardvalue,
                  style: TextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
