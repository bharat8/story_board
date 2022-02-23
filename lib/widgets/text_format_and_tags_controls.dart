import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_board/providers/story_board_provider.dart';

class TextFormatAndTagControls extends StatelessWidget {
  final BoxConstraints constraints;
  const TextFormatAndTagControls({Key? key, required this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storyProv = Provider.of<StoryBoardProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: constraints.maxWidth * 0.15,
          width: !storyProv.isTagsListTapped
              ? constraints.maxWidth * 0.15
              : constraints.maxWidth * 0.95,
          decoration: BoxDecoration(
              color: Colors.blue[200], borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(left: constraints.maxWidth * 0.025),
          padding: EdgeInsets.symmetric(vertical: constraints.maxWidth * 0.03),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (!storyProv.isTagsListTapped) {
                    storyProv.setIsTagsListTapped(true);
                  } else {
                    storyProv.setIsTagsListTapped(false);
                  }
                },
                child: SizedBox(
                  width: constraints.maxWidth * 0.15,
                  height: constraints.maxWidth * 0.15,
                  child: const FittedBox(
                    child: Icon(
                      Icons.person_pin_circle_rounded,
                      color: Colors.white,
                    ),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              if (storyProv.isTagsListTapped) ...[
                const VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: storyProv.selectedFriendsList.isNotEmpty
                          ? CustomScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              slivers: [
                                  SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return Center(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right:
                                                  constraints.maxWidth * 0.04),
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  constraints.maxWidth * 0.02,
                                              vertical: constraints.maxHeight *
                                                  0.005),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            storyProv
                                                .selectedFriendsList[index],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    childCount:
                                        storyProv.selectedFriendsList.length,
                                  ))
                                ])
                          : const Center(
                              child: Text(
                                "No Friends Tagged",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                )
              ],
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.02,
        ),
        Container(
          width: constraints.maxWidth * 0.15,
          height: !storyProv.isFontSizeTapped
              ? constraints.maxWidth * 0.15
              : constraints.maxHeight * 0.4,
          decoration: BoxDecoration(
              color: Colors.blue[200], borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.only(left: constraints.maxWidth * 0.025),
          padding:
              EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (!storyProv.isFontSizeTapped) {
                    storyProv.setIsFontSizeTapped(true);
                  } else {
                    storyProv.setIsFontSizeTapped(false);
                  }
                },
                child: SizedBox(
                  width: constraints.maxWidth * 0.15,
                  height: constraints.maxWidth * 0.15,
                  child: const FittedBox(
                    child: Icon(
                      Icons.font_download_rounded,
                      color: Colors.white,
                    ),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              if (storyProv.isFontSizeTapped) ...[
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: SliderTheme(
                      child: Slider(
                        value: storyProv.currentSliderVal,
                        min: 20,
                        max: 100,
                        divisions: 100,
                        onChanged: (value) {
                          storyProv.setCurrentSliderVal(value);
                        },
                      ),
                      data: const SliderThemeData(
                        trackHeight: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.02,
                )
              ],
            ],
          ),
        ),
      ],
    );
  }
}
