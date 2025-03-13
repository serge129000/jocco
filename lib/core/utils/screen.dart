import 'package:cupertino_modal_sheet/cupertino_modal_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/list_utils.dart';
import 'package:jocco/core/views/home/pages/home.dart';
import 'package:jocco/core/views/home/pages/message.dart';

import '../views/home/pages/history_page.dart';
import '../views/home/pages/profil.dart';
import '../views/widgets/premium_page.dart';

Size size({required BuildContext context}) => MediaQuery.of(context).size;

kPushToPage(_, {required Widget page, bool? isFromBottom}) =>
    Navigator.push(_, _createRoute(nextPage: page, isFromBottom: isFromBottom));
kReplaceToPage(_, {required Widget page}) =>
    Navigator.pushReplacement(_, _createRoute(nextPage: page));
kPushAndRemoveUntil(_, {required Widget page}) =>
    Navigator.pushAndRemoveUntil(_, _createRoute(nextPage: page), (_) => false);
kPopPage(_) => Navigator.pop(_);
//
Route _createRoute({required Widget nextPage, bool? isFromBottom}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => nextPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = isFromBottom != null && isFromBottom
          ? const Offset(0.0, 1.0)
          : const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

bool isKeyBoardActivated({required BuildContext context}) =>
    MediaQuery.of(context).viewInsets.bottom > 0.0;

enum Status { initial, loading, loaded, error }

enum Pages {
  home(correspondingPage: Home(), iconName: 'bottom_1.png'),
  history(correspondingPage: HistoryPage(), iconName: 'bottom_2.png'),
  message(correspondingPage: Message(), iconName: 'bottom_3.png'),
  profil(correspondingPage: Profil(), iconName: 'bottom_4.png');

  const Pages({required this.iconName, required this.correspondingPage});
  final String iconName;
  final Widget correspondingPage;
}

void showSnackbar(
    {required BuildContext context, bool? isError, required Widget content, SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    showCloseIcon: true,
    action: action,
    content: Container(
      height: 70,
      child: content),
    backgroundColor: isError ?? false ? PrimaryColors.second : PrimaryColors.white,
  ));
}

void likeBoostSheet({required BuildContext context}) {
  final nav = Navigator(
    observers: [HeroController()],
    onGenerateRoute: (settings) => CupertinoPageRoute(
      builder: ((context) {
        return Material(
            elevation: 3,
            color: PrimaryColors.first,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: PrimaryColors.gradientF,
                        )),
                  ),
                ),
                Center(child: PremiumPage(data: firstPremiumData)),
              ],
            ));
      }),
    ),
  );
  showCupertinoModalSheet(
    context: context,
    builder: (context) => nav,
  );
}

void getBackSheet({required BuildContext context}) {
  final nav = Navigator(
    observers: [HeroController()],
    onGenerateRoute: (settings) => CupertinoPageRoute(
      builder: ((context) {
        return Material(
            elevation: 3,
            color: PrimaryColors.first,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: PrimaryColors.gradientF,
                        )),
                  ),
                ),
                Center(child: PremiumPage(data: secondPremiumData)),
              ],
            ));
      }),
    ),
  );
  showCupertinoModalSheet(
    context: context,
    builder: (context) => nav,
  );
}

void customSheet({required BuildContext context, required Map<String, dynamic> data}) {
  final nav = Navigator(
    observers: [HeroController()],
    onGenerateRoute: (settings) => CupertinoPageRoute(
      builder: ((context) {
        return Material(
            elevation: 3,
            color: PrimaryColors.first,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: PrimaryColors.gradientF,
                        )),
                  ),
                ),
                Center(child: PremiumPage(data: data, )),
              ],
            ));
      }),
    ),
  );
  showCupertinoModalSheet(
    context: context,
    builder: (context) => nav,
  );
}
