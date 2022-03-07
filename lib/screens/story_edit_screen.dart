import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:story_board/providers/story_board_provider.dart';
import 'package:story_board/screens/tag_people_screen.dart';
import 'package:story_board/widgets/app_bar_back_button.dart';
import 'package:story_board/widgets/app_bar_icon_button.dart';
import 'package:story_board/widgets/image_interactive_class.dart';

class StoryEditScreen extends StatefulWidget {
  final StoryBoardProvider storyProv;

  const StoryEditScreen({Key? key, required this.storyProv}) : super(key: key);

  @override
  State<StoryEditScreen> createState() => _StoryEditScreenState();
}

class _StoryEditScreenState extends State<StoryEditScreen> {
  late TextEditingController _storyTextController;
  late FocusNode _textFocus;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    _storyTextController = TextEditingController();
    _textFocus = FocusNode();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        _textFocus.unfocus();
        widget.storyProv.setTextEnabled(false);
        widget.storyProv.setIsTagsButtonTapped(false);
      }
    });

    widget.storyProv.defaults(MediaQueryData.fromWindow(window).size);

    super.initState();
  }

  @override
  void dispose() {
    _storyTextController.dispose();
    _textFocus.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider.value(
          value: widget.storyProv,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              width: size.width,
              height: size.height - MediaQuery.of(context).padding.top,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      //Image Selected
                      ImageInteractiveClass(
                        constraints: constraints,
                        storyTextController: _storyTextController,
                        textFocus: _textFocus,
                      ),

                      //App Bar With Controls
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            height: constraints.maxHeight * 0.07,
                            width: constraints.maxWidth,
                            color: Colors.blue[200]!.withOpacity(0.4),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04),
                            child: Row(
                              children: [
                                AppBarBackButton(
                                  constraints: constraints,
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                AppBarIconButton(
                                  constraints: constraints,
                                  icon: Icons.person_pin_circle_rounded,
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => TagPeopleScreen(
                                          storyProv: widget.storyProv),
                                    ));
                                    // widget.storyProv.setIsTagsButtonTapped(true);
                                    // _tagFocus.requestFocus();
                                  },
                                ),
                                AppBarIconButton(
                                  constraints: constraints,
                                  icon: Icons.text_fields_rounded,
                                  onTap: () {
                                    widget.storyProv.setTextEnabled(true);
                                    _textFocus.requestFocus();
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    widget.storyProv.onDonePressed();
                                  },
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.height * 0.02,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
