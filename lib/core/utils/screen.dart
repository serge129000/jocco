import 'package:flutter/material.dart';

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
      var begin = isFromBottom != null && isFromBottom? const Offset(0.0, 1.0): const Offset(1.0, 0.0);
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