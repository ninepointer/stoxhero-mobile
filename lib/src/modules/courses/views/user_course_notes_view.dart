import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:url_launcher/url_launcher.dart';

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
            title: Text("Resource ${index + 1}"),
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
