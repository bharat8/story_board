import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_board/screens/home_screen.dart';
import 'package:story_board/utils/color_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.robotoCondensed().fontFamily,
        scaffoldBackgroundColor: ColorUtils.kBackgroundColor,
      ),
      home: const HomeScreen(),
    );
  }
}
