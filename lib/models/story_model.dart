import 'package:story_board/models/selected_friend_model.dart';

class StoryModel {
  final String imageId;
  final String imageLocation;
  final List<SelectedTagModel> imageTags;

  StoryModel({
    required this.imageId,
    required this.imageLocation,
    required this.imageTags,
  });
}
