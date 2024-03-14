import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stoxhero/src/app/app.dart';

class UserCourseNotesView extends StatefulWidget {
  final UserCoursesSubtopics subtopics;
  UserCourseNotesView(this.subtopics);

  @override
  State<UserCourseNotesView> createState() => _UserCourseNotesViewState();
}

class _UserCourseNotesViewState extends State<UserCourseNotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lecture Resources"),
      ),
      body: ListView.builder(
        itemCount: widget.subtopics.notes?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          var note = widget.subtopics.notes?[index] ?? '';
          return ListTile(
            title: Text("Note ${index + 1}"),
            onTap: () {
              _downloadPDF(note);
            },
          );
        },
      ),
    );
  }

  Future<void> _downloadPDF(String url) async {
    try {
      Dio dio = Dio();
      //  Directory appDocumentsDirectory = Directory('downloads/');
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      if (!appDocumentsDirectory.existsSync()) {
        appDocumentsDirectory.createSync(recursive: true);
      }
      String filePath = 'note_${DateTime.now().millisecondsSinceEpoch}.pdf';
      await dio.download(url, filePath);
      print('File downloaded to: $filePath');
      // Handle further actions here, such as opening the downloaded file
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }
}
