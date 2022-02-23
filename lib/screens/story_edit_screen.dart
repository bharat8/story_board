import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:story_board/providers/story_board_provider.dart';
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
  late TextEditingController _tagTextController;
  late FocusNode _tagFocus;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    _storyTextController = TextEditingController();
    _textFocus = FocusNode();
    _tagTextController = TextEditingController();
    _tagFocus = FocusNode();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        _textFocus.unfocus();
        _tagFocus.unfocus();
        widget.storyProv.setTextEnabled(false);
        widget.storyProv.setIsTagsButtonTapped(false);
      }
    });

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
                          tagTextController: _tagTextController,
                          textFocus: _textFocus,
                          tagFocus: _tagFocus),

                      //App Bar With Controls
                      Container(
                        height: constraints.maxHeight * 0.07,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 1,
                                  color: Colors.black12,
                                  offset: Offset(0, 1),
                                  spreadRadius: 1)
                            ]),
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
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
                                widget.storyProv.setIsTagsButtonTapped(true);
                                _tagFocus.requestFocus();
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
                                widget.storyProv.onDonePressed(
                                    MediaQueryData.fromWindow(window).size);
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(fontSize: size.height * 0.02),
                              ),
                            )
                          ],
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
