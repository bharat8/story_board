import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:story_board/providers/story_board_provider.dart';
import 'package:story_board/utils/color_utils.dart';

import 'app_bar_back_button.dart';

class TagScreenAppBar extends StatefulWidget {
  final BoxConstraints constraints;
  final TextEditingController tagTextController;
  final FocusNode tagFocus;
  const TagScreenAppBar({
    Key? key,
    required this.constraints,
    required this.tagFocus,
    required this.tagTextController,
  }) : super(key: key);

  @override
  State<TagScreenAppBar> createState() => _TagScreenAppBarState();
}

class _TagScreenAppBarState extends State<TagScreenAppBar> {
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    final storyProv = Provider.of<StoryBoardProvider>(context, listen: false);
    return Container(
      height: widget.tagFocus.hasFocus
          ? widget.constraints.maxHeight * 0.4
          : widget.constraints.maxHeight * 0.07,
      width: widget.constraints.maxWidth,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 1,
            color: Colors.black12,
            offset: Offset(0, 1),
            spreadRadius: 1)
      ]),
      padding: EdgeInsets.symmetric(
          horizontal: storyProv.tappedOffset != Offset.zero
              ? widget.constraints.maxWidth * 0.08
              : widget.constraints.maxWidth * 0.06),
      child: widget.tagFocus.hasFocus
          ? Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        widget.tagFocus.unfocus();
                      },
                      child: Icon(Icons.close),
                    ),
                    SizedBox(
                      width: widget.constraints.maxWidth * 0.02,
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.tagTextController,
                        focusNode: widget.tagFocus,
                        autofocus: true,
                        decoration:
                            const InputDecoration(hintText: "Search People"),
                        onChanged: (value) {
                          storyProv.onTagSearched(value);
                        },
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            storyProv.onTextSubmitted(value);
                            widget.tagTextController.text = "";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: widget.constraints.maxWidth * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        widget.tagFocus.unfocus();
                        if (widget.tagTextController.text.isNotEmpty) {
                          storyProv
                              .onTextSubmitted(widget.tagTextController.text);
                          widget.tagTextController.text = "";
                        }
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(
                            fontSize: widget.constraints.maxHeight * 0.02),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: widget.constraints.maxHeight * 0.02,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 10,
                          child: ScrollablePositionedList.builder(
                            itemScrollController: itemScrollController,
                            itemCount: storyProv.filteredList.isEmpty
                                ? storyProv.friendsList.length
                                : storyProv.filteredList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  widget.tagTextController.text =
                                      storyProv.filteredList.isEmpty
                                          ? storyProv.friendsList[index].name
                                          : storyProv.filteredList[index];
                                  widget.tagTextController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: widget
                                              .tagTextController.text.length));
                                  storyProv.onTagSearched(
                                      widget.tagTextController.text);
                                },
                                child: Container(
                                  width: widget.constraints.maxWidth,
                                  height: widget.constraints.maxHeight * 0.05,
                                  decoration: BoxDecoration(
                                      color: ColorUtils.kBackgroundColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          widget.constraints.maxHeight * 0.02),
                                  padding: EdgeInsets.only(
                                      left: widget.constraints.maxWidth * 0.02),
                                  child: Text(
                                    storyProv.filteredList.isEmpty
                                        ? storyProv.friendsList[index].name
                                        : storyProv.filteredList[index],
                                  ),
                                ),
                              );
                            },
                          )),
                      SizedBox(
                        width: widget.constraints.maxWidth * 0.08,
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                int scrollIndex = storyProv.friendsList
                                    .indexWhere((element) =>
                                        element.firstAlphabet ==
                                        storyProv.alphabetsList[index]);
                                if (scrollIndex != -1) {
                                  itemScrollController.scrollTo(
                                      index: scrollIndex,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOutCubic);
                                }
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(bottom: 6),
                                alignment: Alignment.center,
                                child: Text(
                                  storyProv.alphabetsList[index],
                                ),
                              ),
                            );
                          },
                          itemCount: storyProv.alphabetsList.length,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: widget.constraints.maxHeight * 0.02,
                ),
              ],
            )
          : Row(
              children: [
                AppBarBackButton(
                  constraints: widget.constraints,
                ),
                const Spacer(
                  flex: 1,
                ),
                const Text(
                  "Tag People",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(
                  flex: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                        fontSize: widget.constraints.maxHeight * 0.02),
                  ),
                )
              ],
            ),
    );
  }
}
