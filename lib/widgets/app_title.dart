import 'package:flutter/material.dart';
import 'package:story_board/utils/color_utils.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "StoryBoard",
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.03,
        fontWeight: FontWeight.w600,
        color: ColorUtils.kPrimaryTextColor.withOpacity(0.8),
      ),
    );
  }
}
