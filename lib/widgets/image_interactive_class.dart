import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_board/providers/story_board_provider.dart';
import 'package:story_board/widgets/text_format_and_tags_controls.dart';

class ImageInteractiveClass extends StatelessWidget {
  final BoxConstraints constraints;
  final TextEditingController storyTextController;
  final TextEditingController tagTextController;
  final FocusNode textFocus;
  final FocusNode tagFocus;
  const ImageInteractiveClass({
    Key? key,
    required this.constraints,
    required this.storyTextController,
    required this.tagTextController,
    required this.textFocus,
    required this.tagFocus,
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
                height: constraints.maxHeight * 0.93,
                width: constraints.maxWidth,
                margin: EdgeInsets.only(
                  top: constraints.maxHeight * 0.07,
                ),
                color: Colors.white,
                child: InteractiveViewer(
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

              // Tags view and edit Controls
              if (storyProv.isTagsButtonTapped)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: TextField(
                          controller: tagTextController,
                          focusNode: tagFocus,
                          decoration:
                              const InputDecoration.collapsed(hintText: ""),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          onChanged: (value) {
                            storyProv.onTagSearched(value);
                          },
                          onSubmitted: (value) {
                            storyProv.onTextSubmitted(value);
                            tagTextController.text = "";
                          },
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.04,
                      ),
                      Container(
                        width: constraints.maxWidth * 0.9,
                        height: constraints.maxHeight * 0.08,
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Center(
                                  child: InkWell(
                                    onTap: () {
                                      tagTextController.text =
                                          storyProv.filteredList.isEmpty
                                              ? storyProv.friendsList[index]
                                              : storyProv.filteredList[index];
                                      tagTextController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: tagTextController
                                                      .text.length));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        storyProv.filteredList.isEmpty
                                            ? storyProv.friendsList[index]
                                            : storyProv.filteredList[index],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: storyProv.filteredList.isEmpty
                                  ? storyProv.friendsList.length
                                  : storyProv.filteredList.length,
                            ))
                          ],
                        ),
                      )
                    ],
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
