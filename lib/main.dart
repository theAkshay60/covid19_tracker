import 'package:covid19tracker/constants.dart';
import 'package:covid19tracker/screens/homepage.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(CoVid19());
}

class CoVid19 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      //defaultBrightness: Brightness.light,
      data: (brightness) {
        return ThemeData(
            primaryColor: primaryBlack,
            fontFamily: 'Circular',
            brightness: brightness == Brightness.light
                ? Brightness.light
                : Brightness.dark,
            scaffoldBackgroundColor: brightness == Brightness.dark
                ? Colors.blueGrey[900]
                : Colors.white);
      },
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          //debugShowCheckedModeBanner: false,
          theme: theme,
          home: HomePage(),
        );
      },
    );
  }
}

//brightness == Brightness.light
//? Brightness.dark
//    : Brightness.light,
//scaffoldBackgroundColor: brightness == Brightness.light
//? Colors.white
//    : Colors.blueGrey[900])
