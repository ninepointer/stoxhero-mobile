import 'dart:async';

import 'package:flutter/material.dart';
import '../../../app/app.dart';

class StoryView extends StatefulWidget {
  const StoryView({super.key});

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  int currentStoryIndex = 0;
  final List<Widget> myStories = [
    Story1(),
    Story2(),
    Story3(),
    Story4(),
    Story5(),
  ];
  List<double> percentageWatched = [];
  @override
  void initState() {
    super.initState();
    //initally all stories have't watch yet
    for (int i = 0; i < myStories.length; i++) {
      percentageWatched.add(0);
    }
    _startWatching();
  }

  void _startWatching() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        //only add 0.01 as long its below 1
        if (percentageWatched[currentStoryIndex] + 0.01 < 1) {
          percentageWatched[currentStoryIndex] += 0.01;
        }
        //if adding 0.01 exceed 1 ,set percentage to 1 and cancle timer
        else {
          percentageWatched[currentStoryIndex] = 1;
          timer.cancel();
          //also go to next story as long as there are more stories to go through
          if (currentStoryIndex < myStories.length - 1) {
            currentStoryIndex++;
            //restart story timer
            _startWatching();
          }
          //if we are finishing the last story then return the homePage
          else {
            Navigator.pop(context);
          }
        }
      });
    });
  }

  void _onTapDown(details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    //user tap first half of the screen then
    if (dx < screenWidth / 2) {
      setState(() {
        if (currentStoryIndex > 0) {
          percentageWatched[currentStoryIndex - 1] = 0;
          percentageWatched[currentStoryIndex] = 0;
          currentStoryIndex--;
        }
      });
    }
    //user tab last half of the screen
    else {
      setState(() {
        if (currentStoryIndex < myStories.length - 1) {
          percentageWatched[currentStoryIndex] = 1;
          currentStoryIndex++;
        } else {
          percentageWatched[currentStoryIndex] = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Story"),
      ),
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details),
        child: Stack(
          children: [
            myStories[currentStoryIndex],
            StoryBar(
              percentWatched: percentageWatched,
            ),
          ],
        ),
      ),
    );
  }
}
