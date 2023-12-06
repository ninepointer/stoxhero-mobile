// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class TimerWidget extends StatefulWidget {
//   final Socket socket;

//   TimerWidget({required this.socket});

//   @override
//   _TimerWidgetState createState() => _TimerWidgetState();
// }

// class _TimerWidgetState extends State<TimerWidget> {
//   DateTime todayDate = DateTime.now();
//   late String remainingTime;
//   late List setting;
//   late String serverTime;
//   late String color;
//   late bool timerVisibility;
//   late bool goingOnline;
//   late List holiday;
//   late List nextTradingDay;
//   late String baseUrl;

//   @override
//   void initState() {
//     super.initState();
//     baseUrl = "http://localhost:5000/"; // Update the base URL
//     remainingTime = "";
//     setting = [];
//     serverTime = "";
//     color = "";
//     timerVisibility = false;
//     goingOnline = false;
//     holiday = [];
//     nextTradingDay = [];
//     fetchData();
//     setupSocket();
//   }

//   // Fetch data from the server
//   void fetchData() async {
//     final settingResponse = await http.get(
//       Uri.parse("$baseUrl/api/v1/readsetting"),
//       headers: {"withCredentials": "true"},
//     );

//     final holidayResponse = await http.get(
//       Uri.parse("$baseUrl/api/v1/tradingholiday/dates/$todayDate/${todayDate}T23:59:00.000Z"),
//       headers: {"withCredentials": "true"},
//     );

//     final nextTradingDayResponse = await http.get(
//       Uri.parse("$baseUrl/api/v1/tradingholiday/nextTradingDay"),
//       headers: {"withCredentials": "true"},
//     );

//     setState(() {
//       setting = settingResponse.data;
//       holiday = holidayResponse.data.data;
//       nextTradingDay = nextTradingDayResponse.data.data;
//     });
//   }

//   // Set up the socket connection
//   void setupSocket() {
//     widget.socket.on("serverTime", (data) {
//       setState(() {
//         serverTime = data;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: timerVisibility
//           ? Column(
//               children: [
//                 Text(
//                   goingOnline ? "You can place trades in:" : "Open trades will be auto squared off in:",
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(2),
//                   decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
//                   child: Text(
//                     remainingTime,
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ],
//             )
//           : remainingTime.isNotEmpty
//               ? Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.circle,
//                       color: color == "green" ? Colors.green : Colors.red,
//                     ),
//                     SizedBox(width: 5),
//                     Text(
//                       remainingTime,
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ],
//                 )
//               : Container(),
//     );
//   }
// }
