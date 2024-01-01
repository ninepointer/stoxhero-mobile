import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../app/app.dart';
import 'package:audioplayers/audioplayers.dart';

class StoryView extends StatefulWidget {
  const StoryView({Key? key}) : super(key: key);

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
    Story41(),
    Story42(),
    Story71(),
    Story7(),
    Story72(),
    Story73(),
    Story74(),
    Story5(),
    // Story6(),
  ];
  List<double> percentageWatched = [];
  bool isPaused = false;
  Timer? timer;

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Initially, all stories haven't been watched yet
    for (int i = 0; i < myStories.length; i++) {
      percentageWatched.add(0);
    }

    _startWatching();
    _playMusic("audio/bgm.mp3");
  }
  void _playMusic(String filePath) async {
  await audioPlayer.play(AssetSource(filePath));
}
  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }
  void _startWatching() {
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (!isPaused) {
        setState(() {
          // Only add 0.01 as long as it's below 1
          if (percentageWatched[currentStoryIndex] + 0.01 < 1) {
            percentageWatched[currentStoryIndex] += 0.01;
          }
          // If adding 0.01 exceeds 1, set percentage to 1 and cancel timer
          else {
            percentageWatched[currentStoryIndex] = 1;
            timer.cancel();
            // Also go to the next story as long as there are more stories to go through
            if (currentStoryIndex < myStories.length - 1) {
              currentStoryIndex++;
              // Restart the story timer
              _startWatching();
            }
            // If we are finishing the last story, then return to the HomePage
            else {
              Navigator.pop(context);
            }
          }
        });
      }
    });
  }

  void _onLongPress() {
    setState(() {
      isPaused = true;
      timer?.cancel();
      audioPlayer.pause(); // Cancel the timer when the story is paused
    });
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    setState(() {
      isPaused = false;
      _startWatching();
      audioPlayer.resume(); // Resume watching when the long press is released
    });
  }

  void _onTapDown (TapUpDetails details) async{
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    // User taps the first half of the screen

    Duration currentPosition = await audioPlayer.getCurrentPosition() ?? Duration();
    Duration newPosition;
    if (dx < screenWidth / 2) {
      setState(() {
        if (currentStoryIndex > 0) {
          //newPosition = Duration(milliseconds: max(0, currentPosition.inMilliseconds - 5000));
          //audioPlayer.seek(newPosition);

          percentageWatched[currentStoryIndex - 1] = 0;
          percentageWatched[currentStoryIndex] = 0;
          currentStoryIndex--;
        }
      });
    }
    // User taps the last half of the screen
    else {
      setState(() {
        if (currentStoryIndex < myStories.length - 1) {
          //newPosition = Duration(milliseconds: currentPosition.inMilliseconds + 5000);
          //audioPlayer.seek(newPosition);

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
        title: Text(
          "StoxHero 2023 in review",
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: GestureDetector(
        onLongPress: _onLongPress,
        onLongPressEnd: _onLongPressEnd,
        onTapUp: _onTapDown,
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
