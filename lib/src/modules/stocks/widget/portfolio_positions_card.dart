import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PositionsCard extends StatelessWidget {
  const PositionsCard({
    Key? key,
    required this.title,
    required this.percentage,
    required this.quantity,
    required this.ltp,
    required this.averageprice,
    required this.imagePath,
  }) : super(key: key);

  final String title;
  final String percentage;
  final String quantity;
  final String ltp;
  final String averageprice;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                // Handle edit action
              },
              icon: Icons.edit,
              backgroundColor: Colors.yellow,
              label: 'Edit',
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (contextFromLayoutBuilder, constraints) {
            bool isSlidableOpen = false; // Add this variable
            return GestureDetector(
              child: Container(
                height: 100,
                width: 400,
                padding: EdgeInsets.only(left: 9, right: 9,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Side
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Image.asset(
                                imagePath,
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  quantity,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  ' Quantity',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Right Side
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '(Average Price)',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  averageprice,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '(LTP)',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  ltp,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              percentage,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      // Add a Divider widget at the bottom
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
    );
  }
}
