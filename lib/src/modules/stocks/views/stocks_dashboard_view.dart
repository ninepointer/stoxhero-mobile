// import 'package:flutter/material.dart';
// import 'package:stoxhero/src/app/app.dart';
// import 'package:stoxhero/src/modules/stocks/widget/watchlist.dart';

// class StocksDashboardView extends StatefulWidget {
//   const StocksDashboardView({Key? key});

//   @override
//   State<StocksDashboardView> createState() => _StocksDashboardViewState();
// }


// //tickerprovider is to connect tabview for each tabbar
// class _StocksDashboardViewState extends State<StocksDashboardView>
//     with TickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 5, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Create a list of featureTabCategory objects for each tab
//     List<featureTabCategory> tabCategories = [
//       featureTabCategory(false, Category("My Watchlist")),
//       featureTabCategory(false, Category("Holdings"),),
//       featureTabCategory(false, Category("Best Stocks"),),
//       featureTabCategory(false, Category("Orders"),),
//       featureTabCategory(false, Category("Funds"),),
//     ];

//     return Scaffold(
// appBar: AppBar(
//   backgroundColor: Colors.green,
//   leading: IconButton(
//     icon: Icon(Icons.arrow_back, color: Colors.black),
//     onPressed: () {
//       // Handle back button press here
//     },
//   ),
//   title: Text("Stocks Trading"),
// ),









//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
           
            
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.all(10),
//                     width: 140,
//                     height: 60,
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(child: Text("NIFTY")),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(10),
//                     width: 140,
//                     height: 60,
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(child: Text("BANKNIFTY")),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(10),
//                     width: 140,
//                     height: 60,
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(child: Text("FINNIFTY")),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(10),
//                     width: 140,
//                     height: 60,
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(child: Text("SENSEX")),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               width: 400,
//               height: 60,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Center(child: Text("Net P&L")),




//             ),
//           Container(
//   height: 80,
  
//   child: TabBar(
    
//     controller: _tabController,
//       //        indicator: BoxDecoration(
//        //       color: Colors.grey, // Change this color to the highlight color you want
//         //      borderRadius: BorderRadius.circular(10),
//           //  ),
//     indicatorWeight: 4.0, // Adjust the indicator weight as needed
//     isScrollable: true,
//     tabs: List.generate(5, (index) => _featureTabWidget(tabCategories[index])),
//      // Add this line for hard edge clipping
//   ),
// ),





            
//             Expanded(
//               child: Container(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                   Container(
//                      color: Colors.white, // Different UI for Tab 1
//                       child: Center(child: Text("Content for Tab 1")),
//                    ),
//                    Container(
//                      color: Colors.blue, // Different UI for Tab 2
//                       child: Center(child: Text("Content for Tab 2")),
//                    ),
//                    Container(
//                     color: Colors.green, // Different UI for Tab 3
//                       child: Center(child: Text("Content for Tab 3")),
//                    ),
//                    Container(
//                     color: Colors.yellow, // Different UI for Tab 4
//                       child: Center(child: Text("Content for Tab 4")),
//                    ),
//                    Container(
//                     color: Colors.orange, // Different UI for Tab 5
//                       child: Center(child: Text("Content for Tab 5")),
//                    ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

 




// class _featureTabWidget extends StatelessWidget {
//   const _featureTabWidget(this.tabCategory);
//   final featureTabCategory tabCategory;

//   @override
//   Widget build(BuildContext context) {
//     final selected = tabCategory.selected;
//     return Opacity(
//       opacity: selected ? 0 : 1,
//       child: Card(
        
//         elevation: selected ? 16 : 0,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             tabCategory.category.name,
            
//             // style: TextStyle(
//             //   fontWeight: FontWeight.bold,
//             //   fontSize: 13,
//             // ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class featureTabCategory {
  
//   final bool selected;
//   final Category category;
  
//   featureTabCategory(this.selected, this.category);
// }

// class Category {
//   final String name;

//   Category(this.name);
// }




