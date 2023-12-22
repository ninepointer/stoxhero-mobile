import 'package:flutter/material.dart';
import '../../../core/core.dart';

class OrdersCard extends StatelessWidget {
  const OrdersCard({
    Key? key,
    required this.quantity,
    required this.price,
    required this.totalamount,
    required this.timestamp,
    required this.orderid,
    required this.status,
    required this.symbol,
    required this.type,
  }) : super(key: key);

  final String quantity;
  final String price;
  final String totalamount;
  final String timestamp;
  final String orderid;
  final String status;
  final String symbol;
  final String type;

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
        padding: const EdgeInsets.only(top:8,left: 8,right: 8,bottom: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status, 
                  style: AppStyles.tsBlackSemiBold16.copyWith(color: status == "COMPLETED" ? Colors.green : Colors.yellow,
               ),
                ),
                SizedBox(height: 5),
                Text(
                  symbol,
                 style: AppStyles.tsBlackMedium14,
                ),
                SizedBox(height: 5),
                Text(
                  "Price ",
                  style: AppStyles.tsGreyRegular12,
                ),
                
                Text(
                  "₹$price",
                 style: AppStyles.tsBlackMedium14,
                ),
                SizedBox(height: 5),
                Text(
                  "Order ID",
                   style: AppStyles.tsGreyRegular12,
                  
                ),
                Text(
                  orderid,
                 style: AppStyles.tsBlackMedium14,
                )
              ],
            ),
        
        
        
            // Right side
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  type,
                  style:  AppStyles.tsBlackSemiBold16.copyWith(color: type == "BUY" ? Colors.green : Colors.red,
                  )
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      quantity,
                     style: AppStyles.tsBlackMedium12,
                    ),
                    Text(
                      " Quantity",
                     style: AppStyles.tsBlackMedium14,
                    ),
                  ],
                ),

                SizedBox(height: 5),
               
                Text(
                  "Amount",
                   style: AppStyles.tsGreyRegular12,
                ),
                 Text(
                  "₹$totalamount",
                   style: AppStyles.tsBlackMedium14,
                ),
                SizedBox(height: 5),
                Text(
                  "Timestamp",
                  style: AppStyles.tsGreyRegular12,
                ),
                Text(
                  timestamp,
                   style: AppStyles.tsBlackMedium14,
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
