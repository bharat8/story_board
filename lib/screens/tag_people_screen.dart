import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:provider/provider.dart';
import 'package:story_board/providers/story_board_provider.dart';
import 'package:story_board/utils/color_utils.dart';
import 'package:story_board/widgets/app_bar_back_button.dart';
import 'package:story_board/widgets/tag_screen_app_bar.dart';
import 'package:story_board/widgets/text_format_and_tags_controls.dart';

class TagPeopleScreen extends StatefulWidget {
  final StoryBoardProvider storyProv;

  const TagPeopleScreen({Key? key, required this.storyProv}) : super(key: key);

  @override
  State<TagPeopleScreen> createState() => _TagPeopleScreenState();
}

class _TagPeopleScreenState extends State<TagPeopleScreen> {
  late TextEditingController _tagTextController;
  late FocusNode _tagFocus;
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    _tagTextController = TextEditingController();
    _tagFocus = FocusNode();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        _tagFocus.unfocus();
        widget.storyProv.setIsTagsButtonTapped(false);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
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
                  return Consumer<StoryBoardProvider>(
                    builder: (context, storyProv, child) {
                      return Stack(
                        children: [
                          //Image Selected
                          PositionedTapDetector2(
                            onTap: (position) {
                              storyProv.setTappedOffset(position.global);
                              FocusScope.of(context).requestFocus(_tagFocus);
                            },
                            child: Container(
                              height: constraints.maxHeight * 0.93,
                              width: constraints.maxWidth,
                              margin: EdgeInsets.only(
                                top: constraints.maxHeight * 0.07,
                              ),
                              color: Colors.white,
                              child: Image.file(
                                File(storyProv.currentStory!.imageLocation),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          if (_tagFocus.hasFocus)
                            Container(
                              height: constraints.maxHeight * 0.93,
                              width: constraints.maxWidth,
                              margin: EdgeInsets.only(
                                top: constraints.maxHeight * 0.07,
                              ),
                              color: Colors.black12,
                            ),

                          if (_tagFocus.hasFocus)
                            Positioned(
                              left: storyProv.tappedOffset.dx -
                                  constraints.maxWidth * 0.15,
                              top: storyProv.tappedOffset.dy -
                                  constraints.maxHeight * 0.07,
                              child: Container(
                                width: constraints.maxWidth * 0.3,
                                height: constraints.maxHeight * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(0.65),
                                ),
                                child: Center(
                                  child: Text(
                                    _tagTextController.text.isEmpty
                                        ? "Who's this ?"
                                        : _tagTextController.text,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),

                          //Tag Controls
                          Positioned(
                              left: 0,
                              top: constraints.maxHeight * 0.1,
                              child: TagControls(constraints: constraints)),

                          if (storyProv.selectedFriendsList.isNotEmpty &&
                              storyProv.isTagsListTapped)
                            Padding(
                              padding: EdgeInsets.only(
                                  top: constraints.maxHeight * 0.07),
                              child: Stack(
                                children: storyProv.selectedFriendsList
                                    .map<Widget>(
                                      (e) => Positioned(
                                        left: e.tagPosition.dx -
                                            (constraints.maxWidth * 0.25),
                                        top: e.tagPosition.dy -
                                            (constraints.maxHeight * 0.07 * 2),
                                        child: SizedBox(
                                          height: constraints.maxHeight * 0.07,
                                          width: constraints.maxWidth * 0.5,
                                          child: Column(
                                            children: [
                                              const Icon(
                                                Icons.person_pin_circle_rounded,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                e.tagName,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black26,
                                                      offset: Offset(1, 1),
                                                      blurRadius: 6,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),

                          //App Bar With Controls
                          TagScreenAppBar(
                              constraints: constraints,
                              tagFocus: _tagFocus,
                              tagTextController: _tagTextController)
                        ],
                      );
                    },
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
