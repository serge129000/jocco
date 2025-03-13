import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/models/chat.dart';
import 'package:jocco/core/models/potential_matching.dart';
import 'package:jocco/core/services/user_services_impl.dart';
import 'package:jocco/core/streams/user_stream.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/screen.dart';

import '../../utils/gender.dart';
import '../../utils/step_utils.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic> _filterData = {};
  Map<String, dynamic> get filterData => _filterData;
  List<String> _interest = [];
  List<String> get interest => _interest;
  List<String> _cat = [];
  List<String> get cat => _cat;
  List<String> _personnality = [];
  List<String> get personnality => _personnality;
  List<AppUser>? _potentialMatchingUsers = [];
  List<AppUser>? get potentialMatchingUsers => _potentialMatchingUsers;
  List<AppUser> _finalUsers = [];
  List<AppUser> get finalUsers => _finalUsers;
  List<AppUser> _passedUser = [];
  List<AppUser> get passedUser => _passedUser;
  late AppinioSwiperController _controller = AppinioSwiperController();
  AppinioSwiperController get controller => _controller;
  Status _gettingPotentialMatchingStatus = Status.initial;
  Status get gettingPotentialMatchingStatus => _gettingPotentialMatchingStatus;
  Status _gettingMyLikers = Status.initial;
  Status get gettingMylikers => _gettingMyLikers;
  Status _gettingMyMatchs = Status.initial;
  Status get gettingMyMatchs => _gettingMyMatchs;
  PotentialUserContent? _potentialMatchingUserContent;
  PotentialUserContent? get potentialMatchingUserContent =>
      _potentialMatchingUserContent;
  PotentialUserContent? _potentialUserLikersContent;
  PotentialUserContent? get potentialUserLikersContent =>
      _potentialUserLikersContent;
  PotentialUserContent? _potentialUserMatchsContent;
  PotentialUserContent? get potentialUserMatchsContent =>
      _potentialUserMatchsContent;
  UserStream userStream = UserStream();
  Status _onUpdatingFilterStatus = Status.initial;
  Status get onUpdatingFilterStatus => _onUpdatingFilterStatus;
  Map<String, List<Chat>> _chats = {};
  Map<String, List<Chat>> get chats => _chats;
  Map<String, List<AppUser>> _rooms = {};
  Map<String, List<AppUser>> get rooms => _rooms;
  (int, int) _currentCardIndex = (0, 0);
  (int, int) get currentCardIndex => _currentCardIndex;
  bool _listFinish = false;
  bool get listFinish => _listFinish;
  Status _gettingUserId = Status.initial;
  Status get gettingUserId => _gettingUserId;
  Map<String, String> _usersRoomid = {};
  Map<String, String> get usersRoomid => _usersRoomid;
  Status _onLikingOrDisliking = Status.initial;
  Status get onLinkingOrDisliking => _onLikingOrDisliking;
  String _currentError = AllText.errorT;
  String get currentError => _currentError;

  void setDistance({required double distanceValue}) {
    _filterData['distance'] = distanceValue;
    notifyListeners();
  }

  void setActivateOrDesactivate({required bool st}) {
    _filterData['st'] = st;
    notifyListeners();
  }

  void setAgeRange({required int ageMin, required int ageMax}) {
    _filterData['ageMin'] = ageMin;
    _filterData['ageMax'] = ageMax;
    notifyListeners();
  }

  void setGender({required Gender gender}) {
    _filterData['gender'] = gender;
    notifyListeners();
  }

  void setProjectTimes({required ProjectTimes projectTime}) {
    _filterData['projectTime'] = projectTime;
    notifyListeners();
  }

  void initProjectCat({required List receivCat}) {
    _filterData['projectCat'] = receivCat;
    notifyListeners();
  }

  void initInterest({required List interest}) {
    _interest = List<String>.from(interest);
    notifyListeners();
  }

  void initPersonnality({required List personnality}) {
    _personnality = List<String>.from(personnality);
    notifyListeners();
  }

  void setProjectCat({required String projectCat}) {
    _cat.add(projectCat);
    _filterData['projectCat'] = _cat;
    notifyListeners();
  }

  void removeCat({required String cat}) {
    _cat.removeWhere((e) => e == cat);
    _filterData['projectCat'] = _cat;
    notifyListeners();
  }

  void setInterestCat({required String interests}) {
    _interest.add(interests);
    _filterData['interests'] = _interest;
    notifyListeners();
  }

  void removeInterestcat({required String interest}) {
    _interest.removeWhere((e) => e == interest);
    _filterData['interests'] = _interest;
    notifyListeners();
  }

  void setPersonnality({required String personnality}) {
    _personnality.add(personnality);
    _filterData['personnality'] = _personnality;
    notifyListeners();
  }

  void removePersonnality({required String personnality}) {
    _personnality.removeWhere((e) => e == personnality);
    _filterData['personnality'] = _personnality;
    notifyListeners();
  }

  void projectDebut({required ProjectTimes projectTimes}) {
    _filterData['projectTimes'] = projectTimes;
    notifyListeners();
  }

  void initMatching() {
    _controller = AppinioSwiperController();
    UserStream().initUserPotentialMatching();
  }

  void startMatching((int, int)? pagingData) {
    UserStream().fetchUserPotentialMatching(pagingData);
  }

  void passUser() {
    _passedUser.add(_finalUsers.removeAt(0));
    print('passed user: $passedUser');
    notifyListeners();
  }

  void getBackToUser() {
    _finalUsers.insert(0, _passedUser.removeAt(_passedUser.length - 1));
    print('back user: $finalUsers');
    notifyListeners();
  }

  void listenToUserMatching({required Function(Object) onError}) {
    UserStream.getPoMatchStream.listen((data) {
      _potentialMatchingUserContent = data.$1;
      _gettingPotentialMatchingStatus = data.$2;
      if (_passedUser.isEmpty) {
        //forcer le _potentialMatchingUsers a etre null quand on a pas une premiere liste d'utilisateur
        _potentialMatchingUsers = data.$1?.content;
      }
      notifyListeners();
      if (data.$1 != null) {
        _potentialMatchingUsers = data.$1?.content;
        setUnfinsihList();
        _finalUsers.addAll(_potentialMatchingUsers ?? []);
      }
      //print("final users: $finalUsers");
      notifyListeners();
    }).onError(onError);
  }

  void listenMyLikers() {
    UserStream.gettingMyLikersStream.listen((data) {
      if (data.$1 != null) {
        _potentialUserLikersContent = data.$1;
      }
      _gettingMyLikers = data.$2;
      notifyListeners();
    });
  }

  void listenMyMatchs() {
    UserStream.gettingMyMatchsStream.listen((data) {
      if (data.$1 != null) {
        _potentialUserMatchsContent = data.$1;
      }
      _gettingMyMatchs = data.$2;
      notifyListeners();
    });
  }

  void refreshUsermatchings((int, int)? pagingData) {
    userStream.fetchUserPotentialMatching(pagingData);
  }

  void refreshUserLikers((int, int)? pagingData) {
    userStream.fetchUserLikers(pagingData);
  }

  void refreshUserMatchs((int, int)? pagingData) {
    userStream.fetchUserMatch(pagingData);
  }

  void listenToUserChat({required AppUser currentUser}) {
    UserServicesImpl().listenUserMessages(
      currentUser: currentUser,
      onNewChat: (chats) {
        chats.forEach((e, v) {
          _chats[e] = List<Chat>.from(v.map((e) => Chat.fromjson(e)));
        });
        notifyListeners();
      },
      rommUsers: (roomUsers) {
        roomUsers.forEach((e, v) {
          _rooms[e] = v;
        });
        notifyListeners();
      },
    );
  }

  Future<void> updateFilter({required Map<String, dynamic> data}) async {
    _onUpdatingFilterStatus = Status.loading;
    notifyListeners();
    try {
      await UserServicesImpl().updateFilter(data: data);
      _finalUsers = [];
      _currentCardIndex = (0, 0);
      setUnfinsihList();
      _onUpdatingFilterStatus = Status.loaded;
      notifyListeners();
    } catch (e) {
      _onUpdatingFilterStatus = Status.error;
      notifyListeners();
    }
  }

  void sendMessage(
      {required String text,
      required String senderId,
      String? roomId,
      required AppUser currentUser,
      required AppUser secondUser,
      required String? uuid}) {
    UserServicesImpl().sendMessages(
        text: text,
        currentUser: currentUser,
        uuid: uuid,
        secondUser: secondUser);
  }

  void setCardIndex((int, int) indexes) {
    _currentCardIndex = indexes;
    notifyListeners();
  }

  void setFinishingList() {
    _listFinish = true;
    notifyListeners();
  }

  void setUnfinsihList() {
    _listFinish = false;
    notifyListeners();
  }

  void setNewController({required AppinioSwiperController c}) {
    _controller = c;
    notifyListeners();
  }

  void likeUser({required String userId}) async {
    _onLikingOrDisliking = Status.loading;
    notifyListeners();
    try {
      await UserServicesImpl().likeUser(userId: userId);
      _onLikingOrDisliking = Status.loaded;
      notifyListeners();
    } catch (e) {
      _onLikingOrDisliking = Status.error;
      _currentError = e.toString();
      notifyListeners();
    } finally {
      _onLikingOrDisliking = Status.initial;
      _currentError = AllText.errorT;
      notifyListeners();
    }
  }

  void disLikeUser({required String userId}) async {
     _onLikingOrDisliking = Status.loading;
    notifyListeners();
    try {
      await UserServicesImpl().dislikeUser(userId: userId);
      _onLikingOrDisliking = Status.loaded;
      notifyListeners();
    } catch (e) {
      _onLikingOrDisliking = Status.error;
      _currentError = e.toString();
      notifyListeners();
    } finally {
      _onLikingOrDisliking = Status.initial;
      _currentError = AllText.errorT;
      notifyListeners();
    }
  }

  Future<void> getRoomId(
      {required String secondUserId, required AppUser currentUser}) async {
    _gettingUserId = Status.loading;
    notifyListeners();
    try {
      _usersRoomid[secondUserId] = await UserServicesImpl()
          .getRoomId(secondUserId: secondUserId, currentUser: currentUser);
      _gettingUserId = Status.loaded;
      notifyListeners();
    } catch (e) {
      _gettingUserId = Status.error;
      notifyListeners();
    }
  }
}
