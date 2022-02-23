import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_board/models/story_model.dart';
import 'package:uuid/uuid.dart';

class StoryBoardProvider extends ChangeNotifier {
  late List<StoryModel> _storiesList;
  StoryModel? _currentStory;
  late bool _textEnabled;
  late Offset _textOffset;
  late bool _isFontSizeTapped;
  late double _currentSliderVal;
  late bool _isTagsButtonTapped;
  List<String> friendsList = [
    "Bharat Sundal",
    "Aakash Bhadana",
    "Vasu Kaushik",
    "Sapan Shah",
    "Amr Badr",
    "Mudit Agarwala",
    "Shubham Baldawa",
    "Pavneet Kohli",
    "Tanya Dewan",
    "Shubhi Saxena",
    "Khushboo Verma",
    "Nishtha Singh",
    "Aishwarya Saxena",
    "Serena N",
    "Karan Arora",
    "Seema Mohan",
  ];
  late bool _isTagsListTapped;
  late List<String> _filteredList;
  late List<String> _selectedFriendsList;

  List<StoryModel> get getStoriesList => _storiesList;

  StoryModel? get currentStory => _currentStory;

  bool get textEnabled => _textEnabled;

  Offset get textOffset => _textOffset;

  bool get isFontSizeTapped => _isFontSizeTapped;

  double get currentSliderVal => _currentSliderVal;

  bool get isTagsButtonTapped => _isTagsButtonTapped;

  bool get isTagsListTapped => _isTagsListTapped;

  List<String> get selectedFriendsList => _selectedFriendsList;

  List<String> get filteredList => _filteredList;

  StoryBoardProvider(Size size) {
    defaults(size);
  }

  addStoriesToList(StoryModel story) {
    _storiesList.add(story);
    notifyListeners();
  }

  setCurrentStory(StoryModel story) {
    _currentStory = story;
    notifyListeners();
  }

  setTextEnabled(bool val) {
    _textEnabled = val;
    notifyListeners();
  }

  setTextOffset(Offset offset) {
    _textOffset = offset;
    notifyListeners();
  }

  setIsFontSizeTapped(bool val) {
    _isFontSizeTapped = val;
    notifyListeners();
  }

  setCurrentSliderVal(double val) {
    _currentSliderVal = val;
    notifyListeners();
  }

  setIsTagsButtonTapped(bool val) {
    _isTagsButtonTapped = val;
    notifyListeners();
  }

  setIsTagsListTapped(bool val) {
    _isTagsListTapped = val;
    notifyListeners();
  }

  addToSelectedList(String name) {
    _selectedFriendsList.add(name);
    notifyListeners();
  }

  pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageId = const Uuid().v1();
      _currentStory = StoryModel(
        imageId: imageId,
        imageLocation: image.path,
        imageTags: [],
      );
    }
  }

  onTagSearched(String val) {
    List<String> tempList = [];
    for (var i = 0; i < friendsList.length; i++) {
      if (friendsList[i].toLowerCase().startsWith(val.toLowerCase())) {
        tempList.add(friendsList[i]);
      }
    }
    _filteredList = tempList;
    notifyListeners();
  }

  onTextSubmitted(String val) {
    addToSelectedList(val);
    _filteredList = [];
    notifyListeners();
  }

  onDonePressed(Size size) {
    if (_currentStory != null) {
      StoryModel model = StoryModel(
        imageId: _currentStory!.imageId,
        imageLocation: _currentStory!.imageLocation,
        imageTags: _selectedFriendsList,
      );
      addStoriesToList(model);
    }
    defaults(size);
  }

  defaults(Size size) {
    _storiesList = [];
    _textEnabled = false;
    _textOffset = Offset(size.width / 2, size.height / 2);
    _isFontSizeTapped = false;
    _currentSliderVal = 40;
    _isTagsButtonTapped = false;
    _isTagsListTapped = false;
    _selectedFriendsList = [];
    _filteredList = [];
  }
}
