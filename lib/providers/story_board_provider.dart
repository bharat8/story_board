import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_board/models/friends_list_model.dart';
import 'package:story_board/models/selected_friend_model.dart';
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
  List<FriendsListModel> friendsList = [
    FriendsListModel(firstAlphabet: "B", name: "Bharat Sundal"),
    FriendsListModel(firstAlphabet: "A", name: "Aakash Bhadana"),
    FriendsListModel(firstAlphabet: "V", name: "Vasu Kaushik"),
    FriendsListModel(firstAlphabet: "S", name: "Sapan Shah"),
    FriendsListModel(firstAlphabet: "A", name: "Amr Badr"),
    FriendsListModel(firstAlphabet: "M", name: "Mudit Agarwala"),
    FriendsListModel(firstAlphabet: "S", name: "Shubham Baldawa"),
    FriendsListModel(firstAlphabet: "P", name: "Pavneet Kohli"),
    FriendsListModel(firstAlphabet: "T", name: "Tanya Dewan"),
    FriendsListModel(firstAlphabet: "S", name: "Shubhi Saxena"),
    FriendsListModel(firstAlphabet: "K", name: "Khushboo Verma"),
    FriendsListModel(firstAlphabet: "N", name: "Nishtha Singh"),
    FriendsListModel(firstAlphabet: "A", name: "Aishwarya Saxena"),
    FriendsListModel(firstAlphabet: "S", name: "Serena N"),
    FriendsListModel(firstAlphabet: "K", name: "Karan Arora"),
    FriendsListModel(firstAlphabet: "S", name: "Seema Mohan"),
  ];
  late bool _isTagsListTapped;
  late List<String> _filteredList;
  late List<SelectedTagModel> _selectedFriendsList;
  late Offset _tappedOffset;

  final List<String> alphabetsList = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  List<StoryModel> get getStoriesList => _storiesList;

  StoryModel? get currentStory => _currentStory;

  bool get textEnabled => _textEnabled;

  Offset get textOffset => _textOffset;

  bool get isFontSizeTapped => _isFontSizeTapped;

  double get currentSliderVal => _currentSliderVal;

  bool get isTagsButtonTapped => _isTagsButtonTapped;

  bool get isTagsListTapped => _isTagsListTapped;

  List<SelectedTagModel> get selectedFriendsList => _selectedFriendsList;

  List<String> get filteredList => _filteredList;

  Offset get tappedOffset => _tappedOffset;

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

  addToSelectedList(SelectedTagModel tagModel) {
    _selectedFriendsList.add(tagModel);
    notifyListeners();
  }

  setTappedOffset(Offset val) {
    _tappedOffset = val;
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
    if (val.isNotEmpty) {
      for (var i = 0; i < friendsList.length; i++) {
        if (friendsList[i].name.toLowerCase().startsWith(val.toLowerCase())) {
          tempList.add(friendsList[i].name);
        }
      }
    }
    _filteredList = tempList;
    notifyListeners();
  }

  onTextSubmitted(String val) {
    addToSelectedList(
        SelectedTagModel(tagPosition: _tappedOffset, tagName: val));
    _filteredList = [];
    notifyListeners();
  }

  onDonePressed() {
    if (_currentStory != null) {
      StoryModel model = StoryModel(
        imageId: _currentStory!.imageId,
        imageLocation: _currentStory!.imageLocation,
        imageTags: _selectedFriendsList,
      );
      addStoriesToList(model);
    }
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
    _tappedOffset = Offset.zero;
    friendsList.sort((a, b) => a.firstAlphabet.compareTo(b.firstAlphabet));
  }
}
