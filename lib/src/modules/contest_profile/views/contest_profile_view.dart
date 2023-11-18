import 'package:flutter/material.dart';
import '../../../app/app.dart';

class ContestProfileView extends StatelessWidget {
  const ContestProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contest Profile'),
      ),
      body: Column(children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              CircleAvatar(radius: 45),
              Text('Darshan Vegad'),
              Text('@darshan.vegad'),
              Text('Member Since 11th Nov 2023')
            ],) ,
        ),
        SizedBox(height: 10),
        CommonTile(label: 'Earnings'),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonCardTile(label: 'Arenas Played', value: '250', isCenterAlign: true),
                CommonCardTile(label: 'Arenas Won', value: '200',isCenterAlign: true),
                CommonCardTile(label: 'Arenas Played', value: '250',isCenterAlign: true),
                CommonCardTile(label: 'Arenas Played', value: '250',isCenterAlign: true),
            ],),
          ),
        ),
        SizedBox(height: 10),
        CommonTile(label:'Recent Performance'),
        Container(
          child: Column(
            children: [
              ContestPerformanceCard(),
              SizedBox(height: 10),
              ContestPerformanceCard(),
              SizedBox(height: 10),
              ContestPerformanceCard(),
              SizedBox(height: 10),
              ContestPerformanceCard(),
            ],
          )
        )
      ]),
    );
  }
}

// class ContestPerformanceCard extends StatelessWidget {
//   const ContestPerformanceCard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('#99 Friday Titans - 17th Nov'),
//                 Text('17th Nov 2023'),
//             ],),
//           Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Rank: #19'),
//               Text('Earnings: Rs. 13'),
//               Text('Type: StoxHero'),
//             ],
//           )
//         ]),
//       ),
//     );
//   }
// }