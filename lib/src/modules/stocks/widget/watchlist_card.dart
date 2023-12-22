import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WatchlistCard extends StatelessWidget {
 

  const WatchlistCard({Key? key, 

  required this.imagePath, 
  required this.title, 
  required this.price, 
  required this.percentage,
  
  }) : super(key: key);


 final String imagePath;
 final String title;
 final String price;
 final String percentage;

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Slidable(
                startActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        // Handle phone action
                      },
                      icon: Icons.shopping_cart,
                      backgroundColor: Colors.green,
                      label: 'BUY',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        // Handle delete action
                      },
                      icon: Icons.shopping_cart,
                      backgroundColor: Colors.red,
                      label: 'SELL',
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (contextFromLayoutBuilder, constraints) {
                    bool isSlidableOpen = false; // Add this variable
                    // ...

return GestureDetector(
  child: Container(
    height: 75,
    width: 400,
    padding: EdgeInsets.only(left:9,right:9,top: 5,bottom:5),
    color: Colors.white,
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Image.asset(
                imagePath,
                height: 20,
                width: 20,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  percentage,
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider( // Add a Divider widget at the bottom
          color: Colors.grey[200],
          thickness: 1.0,
        ),
      ],
    ),
  ),
  onTap: () {
    final slidable = Slidable.of(contextFromLayoutBuilder);
    if (isSlidableOpen) {
      slidable?.close();
    } else {
      slidable?.openStartActionPane(
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    }
    isSlidableOpen = !isSlidableOpen; // Toggle the state
  },
);


                  },
                ),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        // Handle delete action
                      },
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                      label: 'DELETE',
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
