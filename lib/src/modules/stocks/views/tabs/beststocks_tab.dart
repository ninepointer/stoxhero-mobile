import 'package:flutter/material.dart';

class BestStocks extends StatefulWidget {
  @override
  _BestStocksState createState() => _BestStocksState();
}

class _BestStocksState extends State<BestStocks> {
  List<StockData> stocks = List.generate(
    6,
    // (index) => StockData(
    //   name: "Stock $index",
    //   price: "Price $index",
    //   imageLocation: 'assets/images/10Xlogo.jpg',
    //   percentageChange: "+0.70(3.01%)",
    (index) {
      if (index == 0) {
        return StockData(
          name: "Reliance",
          price: "₹23.95",
          imageLocation: 'assets/images/10Xlogo.jpg',
          percentageChange: "+0.70(3.01%)",
        );
      } else if (index == 1) {
        return StockData(
          name: "Tata Power Company",
          price: "₹323.55",
          imageLocation: 'assets/images/10Xlogo.jpg',
          percentageChange: "-2.25(0.69%)",
        );
      } else if (index == 2) {
        // Add more conditions for other stocks if needed
        return StockData(
          name: "Adani Total Gas",
          price: "₹1156.80",
          imageLocation: 'assets/images/10Xlogo.jpg',
          percentageChange: "-1.80(0.16%)",
        );
      } else {
        // Add more conditions for other stocks if needed
        return StockData(
          name: "Adani Energy Solution",
          price: "₹1131.50",
          imageLocation: 'assets/images/10Xlogo.jpg',
          percentageChange: "-67.20(5.16%)",
        );
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 11.0,
            mainAxisSpacing: 11.0,
          ),
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            return buildStockCard(stocks[index]);
          },
        ),
      ),
    );
  }

  Widget buildStockCard(StockData stock) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        
        borderRadius: BorderRadius.circular(15.0),
        
      ),
      
    
   
  
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image (10x logo)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 0),
                child: Image.asset(
                  stock.imageLocation,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              //Stock information
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.name.length > 15
                          ? '${stock.name.substring(0, 13)}...'
                          : stock.name,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      stock.price,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      stock.percentageChange,
                      style: TextStyle(
                        color: stock.percentageChange.startsWith('+') ? Colors.green : Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: IconButton(
              onPressed: () {
                // Add your button functionality here
              },
              icon: Icon(Icons.add),
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class StockData {
  final String name;
  final String price;
  final String imageLocation;
  final String percentageChange;

  StockData({
    required this.name,
    required this.price,
    required this.imageLocation,
    required this.percentageChange,
  });
}
