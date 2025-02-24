import 'dart:async';

import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/models/potential_matching.dart';
import 'package:jocco/core/services/user_services_impl.dart';

class UserStream {
  static StreamController<List<AppUser>?> gettingPotentialMatchController =
      StreamController<List<AppUser>?>();
  static Sink<List<AppUser>?> getPoMatchSink =
      gettingPotentialMatchController.sink;
  static Stream<List<AppUser>?> getPoMatchStream =
      gettingPotentialMatchController.stream;
  late PotentialMatchingContent potentialMatchingContent;
  List<AppUser> potentialMacthUsers = [];
  List<AppUser> usersMatchedOrNotList = [];

  void initUserPotentialMatching() {
    getPoMatchSink.add(null);
  }

  void fetchUserPotentialMatching((int, int)? pagingData) async {
    try {
      potentialMatchingContent =
          await UserServicesImpl().getPotentialMatchings(paginData: pagingData);
      //print('is here ${potentialMatchingContent.content}');
      potentialMacthUsers.addAll(potentialMatchingContent.content);
      usersMatchedOrNotList = potentialMacthUsers;
      getPoMatchSink.add(usersMatchedOrNotList);
    } catch (e) {
      gettingPotentialMatchController.sink.addError(e);
    }
  }
}
