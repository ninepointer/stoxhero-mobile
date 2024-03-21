import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_storage/get_storage.dart';

class UserResourcesView extends StatefulWidget {
  final UserMyCoursesData? data;
  UserResourcesView(this.data);

  @override
  State<UserResourcesView> createState() => _UserResourcesViewState();
}

class _UserResourcesViewState extends State<UserResourcesView> {
  @override
  Widget build(BuildContext context) {
    // Check if there are any subtopics with notes
    bool hasSubtopicsWithNotes = false;
    for (var topic in widget.data?.topics ?? []) {
      for (var subtopic in topic.subtopics ?? []) {
        if (subtopic.notes?.isNotEmpty ?? false) {
          hasSubtopicsWithNotes = true;
          break;
        }
      }
      if (hasSubtopicsWithNotes) {
        break;
      }
    }

    // If there are no subtopics with notes, display "No Notes Available" message
    if (!hasSubtopicsWithNotes) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Course Resources"),
        ),
        body: Center(
          child: Text(
            "No Notes Available",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    // If there are subtopics with notes, display the list
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Resources"),
      ),
      body: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.data?.topics?.length,
        itemBuilder: (context, index) {
          var item = widget.data?.topics?[index];

          // Filter out subtopics that do not have notes
          List<UserCoursesSubtopics> subtopicsWithNotes = item!.subtopics!
              .where((subtopic) => subtopic.notes!.isNotEmpty)
              .toList();

          if (subtopicsWithNotes.isEmpty) {
            return Container();
          }

          return Container(
            margin: EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Section ${index + 1} -  ${item?.topic ?? ''}",
                  style: AppStyles.tsSecondaryMedium14
                      .copyWith(color: AppColors.lightGreen),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.0306,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display subtopics
                    ...subtopicsWithNotes.map((subtopic) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${subtopic.topic}",
                            style: Theme.of(context).textTheme.tsRegular18,
                            textAlign: TextAlign.start,
                          ),
                          // Display notes
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: subtopic.notes!.length,
                            itemBuilder: (context, index) {
                              var note = subtopic.notes![index];
                              return ListTile(
                                title: Text(
                                  "${subtopic.topic ?? ''} - ${index + 1}",
                                  style: Get.isDarkMode
                                      ? AppStyles.tsWhiteRegular14
                                      : AppStyles.tsBlackRegular14,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () {
                                        _downloadAndOpenPDF(note, view: true);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.download),
                                      onPressed: () {
                                        _downloadAndOpenPDF(note, view: false);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Divider(), // Add a divider between subtopics
                        ],
                      );
                    }).toList(),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _downloadAndOpenPDF(String url, {required bool view}) async {
    try {
      Dio dio = Dio();
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      if (!appDocumentsDirectory.existsSync()) {
        appDocumentsDirectory.createSync(recursive: true);
      }
      String filePath =
          '${appDocumentsDirectory.path}/note_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await dio.download(url, filePath);
      print('File downloaded to: $filePath');

      if (view) {
        // Open the PDF file using PDFView widget
        _openPDF(filePath);
      } else {
        // Launch the URL to download the PDF file in the default web browser
        await launch(url);
      }
    } catch (e) {
      print('Error downloading or opening PDF: $e');
    }
  }

  void _openPDF(String filePath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PDFView(
          filePath: filePath,
        ),
      ),
    );
  }
}
