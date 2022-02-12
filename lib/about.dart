import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: AutoSizeText(
          "This tutorial shows you how to build explicit animations in Flutter. After introducing some of the essential concepts, classes, and methods in the animation library, it walks you through 5 animation examples. The examples build on each other, introducing you to different aspects of the animation" + 
          "library.The Flutter SDK also provides built-in explicit animations, such as FadeTransition, SizeTransition, and SlideTransition. These simple animations "+
          "are triggered by setting a beginning and ending point. They are simpler to implement than custom explicit animations, which are described here.",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.merge(TextStyle(color: Colors.white)),
        ));
  }
}
