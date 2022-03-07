import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_board/providers/story_board_provider.dart';
import 'package:story_board/widgets/text_format_and_tags_controls.dart';

class ImageInteractiveClass extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController storyTextController;
  final FocusNode textFocus;
  const ImageInteractiveClass({
    Key? key,
    required this.constraints,
    required this.storyTextController,
    required this.textFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryBoardProvider>(
      builder: (context, storyProv, child) {
        if (storyProv.currentStory != null) {
          return Stack(
            children: [
              // Image with interactivity
              Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                color: Colors.white,
                child: InteractiveViewer(
                  maxScale: 10,
                  minScale: 0.1,
                  boundaryMargin: EdgeInsets.all(double.infinity),
                  child: Image.file(
                    File(storyProv.currentStory!.imageLocation),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //Translucent Background for text editing
              if (storyProv.textEnabled || storyProv.isTagsButtonTapped)
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  color: Colors.black.withOpacity(0.6),
                ),

              //Text Field and Text Drag Options
              if (storyProv.textEnabled)
                Center(
                  child: SizedBox(
                    width: constraints.maxWidth * 0.7,
                    child: TextField(
                      maxLines: null,
                      controller: storyTextController,
                      focusNode: textFocus,
                      decoration: const InputDecoration.collapsed(hintText: ""),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: storyProv.currentSliderVal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              else
                Positioned(
                  left: storyProv.textOffset.dx,
                  top: storyProv.textOffset.dy,
                  child: GestureDetector(
                    onTap: () {
                      storyProv.setTextEnabled(true);
                      textFocus.requestFocus();
                    },
                    onPanUpdate: (details) {
                      storyProv.setTextOffset(
                        Offset(storyProv.textOffset.dx + details.delta.dx,
                            storyProv.textOffset.dy + details.delta.dy),
                      );
                    },
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth * 0.7,
                      ),
                      child: Text(
                        storyTextController.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: storyProv.currentSliderVal,
                          color: Colors.white,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              offset: Offset(1, 1),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              if (storyProv.selectedFriendsList.isNotEmpty &&
                  storyProv.isTagsListTapped)
                Container(
                  height: constraints.maxHeight * 0.93,
                  width: constraints.maxWidth,
                  margin: EdgeInsets.only(
                    top: constraints.maxHeight * 0.07,
                  ),
                  child: Stack(
                    children: storyProv.selectedFriendsList
                        .map<Widget>((e) => Positioned(
                            left: e.tagPosition.dx -
                                (constraints.maxWidth * 0.25),
                            top: e.tagPosition.dy -
                                (constraints.maxHeight * 0.07 * 2),
                            child: SizedBox(
                              height: constraints.maxHeight * 0.07,
                              width: constraints.maxWidth * 0.5,
                              child: Column(
                                children: [
                                  const Expanded(
                                    child: Icon(
                                      Icons.person_pin_circle_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
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
                                    ),
                                  )
                                ],
                              ),
                            )))
                        .toList(),
                  ),
                ),

              // Text Format And Tags View Controls
              Positioned(
                left: 0,
                top: constraints.maxHeight * 0.1,
                child: TextFormatAndTagControls(constraints: constraints),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
