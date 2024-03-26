// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:stoxhero/src/app/app.dart';

// class CourseAllTopicView extends StatefulWidget {
//   final UserMyCoursesData? data;

//   CourseAllTopicView(this.data);

//   @override
//   State<CourseAllTopicView> createState() => _CourseAllTopicViewState();
// }

// class _CourseAllTopicViewState extends State<CourseAllTopicView> {
//   late CourseController controller;
//   int expandedIndex = -1;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.find<CourseController>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${widget.data?.courseName ?? ''}"),
//       ),
//       body: ListView.builder(
//         physics: AlwaysScrollableScrollPhysics(),
//         itemCount: widget.data?.topics?.length,
//         itemBuilder: (context, index) {
//           var data = widget.data?.topics?[index];

//           return CommonCard(
//             margin: EdgeInsets.only(bottom: 8),
//             onTap: () {
//               setState(() {
//                 expandedIndex = expandedIndex == index ? -1 : index;
//               });
//             },
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "${index + 1}. ${data?.topic ?? ''}",
//                     style: AppStyles.tsSecondaryRegular16
//                         .copyWith(color: AppColors.lightGreen),
//                   ),
//                   (data?.subtopics?.length ?? 0) > 0
//                       ? Icon(
//                           expandedIndex == index
//                               ? Icons.expand_less_rounded
//                               : Icons.expand_more_rounded,
//                           color: AppColors.grey,
//                         )
//                       : SizedBox()
//                 ],
//               ),
//               if (expandedIndex == index)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: data!.subtopics!
//                       .asMap()
//                       .entries
//                       .map((entry) => GestureDetector(
//                             onTap: () {
//                               Get.to(() =>
//                                   CourseVideoView(widget.data, entry.value));
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               margin: EdgeInsets.only(
//                                   bottom: MediaQuery.of(context).size.width *
//                                       0.0204),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "${entry.key + 1}. ",
//                                     style:
//                                         Theme.of(context).textTheme.tsRegular14,
//                                     textAlign: TextAlign.start,
//                                   ),
//                                   Image.network(
//                                     entry.value.videoKey ?? '',
//                                     width: 50,
//                                     height: 50,
//                                     fit: BoxFit.cover,
//                                     errorBuilder:
//                                         (context, exception, stackTrace) {
//                                       return Image.asset(
//                                         AppImages.lightAppLogo,
//                                         height: 50,
//                                         width: 50,
//                                       );
//                                     },
//                                   ),
//                                   SizedBox(
//                                     width: MediaQuery.of(context).size.width *
//                                         0.0306,
//                                   ),
//                                   Expanded(
//                                     child: Row(
//                                       children: [
//                                         Flexible(
//                                           child: Text(
//                                             "${entry.value.topic}",
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .tsRegular16,
//                                             textAlign: TextAlign.start,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ))
//                       .toList(),
//                 )
//             ],
//           );
//           // GestureDetector(
//           //   onTap: () {
//           //     //  Get.to(() => CourseVideoView());
//           //   },
//           //   child: Container(
//           //     width: double.infinity,
//           //     color: Get.isDarkMode
//           //         ? AppColors.darkCardBackgroundColor
//           //         : AppColors.lightCardBackgroundColor,
//           //     margin: EdgeInsets.only(bottom: 8, top: 8),
//           //     child: Padding(
//           //       padding:
//           //           const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           //       child: Row(
//           //         mainAxisAlignment: MainAxisAlignment.start,
//           //         children: [
//           //           Expanded(
//           //             child: Container(
//           //               child: Text(
//           //                 "${index + 1}. ${data?.topic ?? ''}",
//           //                 style: Get.isDarkMode
//           //                     ? AppStyles.tsWhiteRegular16
//           //                     : AppStyles.tsBlackRegular16,
//           //               ),
//           //             ),
//           //           ),
//           //         ],
//           //       ),
//           //     ),
//           //   ),
//           // );
//         },
//       ),
//     );
//   }
// }
