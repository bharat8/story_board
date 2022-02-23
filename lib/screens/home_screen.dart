import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_board/providers/story_board_provider.dart';
import 'package:story_board/screens/story_edit_screen.dart';
import 'package:story_board/widgets/app_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.02, horizontal: size.width * 0.04),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppTitle(),
                ChangeNotifierProvider(
                  create: (context) => StoryBoardProvider(
                      MediaQueryData.fromWindow(window).size),
                  builder: (context, child) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          StoryBoardProvider storyProv =
                              Provider.of<StoryBoardProvider>(context,
                                  listen: false);
                          await storyProv.pickImage(context);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                StoryEditScreen(storyProv: storyProv),
                          ));
                        },
                        child: SizedBox(
                          width: size.width * 0.4,
                          height: size.width * 0.4,
                          child: FittedBox(
                            child:
                                Image.asset("assets/images/image-picker.png"),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
