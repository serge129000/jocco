import 'dart:async';

import 'package:jocco/core/models/app_user.dart';
import 'package:jocco/core/models/potential_matching.dart';
import 'package:jocco/core/services/user_services_impl.dart';
import 'package:jocco/core/utils/screen.dart';

class UserStream {
  static StreamController<(PotentialUserContent?, Status)>
      gettingPotentialMatchController =
      StreamController<(PotentialUserContent?, Status)>();
  static Sink<(PotentialUserContent?, Status)> getPoMatchSink =
      gettingPotentialMatchController.sink;
  static Stream<(PotentialUserContent?, Status)> getPoMatchStream =
      gettingPotentialMatchController.stream;
  static StreamController<(PotentialUserContent?, Status)>
      gettingMyLikersController =
      StreamController<(PotentialUserContent?, Status)>();
  static Sink<(PotentialUserContent?, Status)> gettingMyLikersSink =
      gettingMyLikersController.sink;
  static Stream<(PotentialUserContent?, Status)> gettingMyLikersStream =
      gettingMyLikersController.stream;
  static StreamController<(PotentialUserContent?, Status)>
      gettingMyMatchsController =
      StreamController<(PotentialUserContent?, Status)>();
  static Sink<(PotentialUserContent?, Status)> gettingMyMatchsSink =
      gettingMyMatchsController.sink;
  static Stream<(PotentialUserContent?, Status)> gettingMyMatchsStream =
      gettingMyMatchsController.stream;

  void initUserPotentialMatching() {
    getPoMatchSink.add((null, Status.initial));
  }

  void fetchUserPotentialMatching((int, int)? pagingData) async {
    List<AppUser> potentialMacthUsers = [];
    getPoMatchSink.add((null, Status.loading));
    try {
      final potentialMatchingContent =
          await UserServicesImpl().getPotentialMatchings(paginData: pagingData);
      potentialMacthUsers.addAll(potentialMatchingContent.content);
      getPoMatchSink.add((potentialMatchingContent, Status.loaded));
    } catch (e) {
      getPoMatchSink.add((null, Status.error));
      gettingPotentialMatchController.sink.addError(e);
    }
  }

  void fetchUserLikers((int, int)? pagingData) async {
    gettingMyLikersSink.add((null, Status.loading));
    try {
      final myLikers =
          await UserServicesImpl().getMyLikers(paginData: pagingData);
      gettingMyLikersSink.add((myLikers, Status.loaded));
    } catch (e) {
      gettingMyLikersSink.add((null, Status.error));
      gettingMyLikersController.sink.addError(e);
    }
  }

  void fetchUserMatch((int, int)? pagingData) async {
    gettingMyMatchsSink.add((null, Status.loading));
    try {
      final myMatchs =
          await UserServicesImpl().getMyMatches(paginData: pagingData);
      gettingMyMatchsSink.add((myMatchs, Status.loaded));
    } catch (e) {
      print(e);
      gettingMyMatchsSink.add((null, Status.error));
      gettingMyMatchsController.sink.addError(e);
    }
  }
}
