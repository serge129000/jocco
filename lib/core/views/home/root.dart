import 'package:flutter/material.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/providers/auth_provider.dart';
import 'package:jocco/core/views/providers/page_provider.dart';
import 'package:jocco/core/views/providers/user_provider.dart';
import 'package:jocco/core/views/widgets/bottom_navigation.dart';
import 'package:jocco/core/views/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late UserProvider userProvider;
  late AppAuthProvider authProvider;
  @override
  void initState() {
    userProvider = context.read<UserProvider>();
    authProvider = context.read<AppAuthProvider>();
    Future.delayed(Duration.zero, () {
      userProvider.initMatching();
      userProvider.startMatching(null);
      userProvider.refreshUserLikers(null);
      userProvider.refreshUserMatchs(null);
      userProvider.listenToUserMatching(onError: (err) {
        //: implementation de l'erreur
      });
      userProvider.listenMyLikers();
      userProvider.listenMyMatchs();
      userProvider.listenToUserChat(currentUser: authProvider.currentAppUser!);
    });
    userProvider.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    userProvider.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(builder: (context, pageProvider, widgets) {
      return CustomScaffold(
        body: pageProvider.currentPage.correspondingPage,
        bottomNavigation: const BottomNavigation(),
      );
    });
  }

  void listener() {
    if (userProvider.onLinkingOrDisliking == Status.error) {
      showSnackbar(
          context: context,
          action: SnackBarAction(
              label: 'Boost',
              onPressed: () {
                likeBoostSheet(context: context);
              }),
          isError: true,
          content: Text(
            userProvider.currentError,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: PrimaryColors.white,
                ),
          ));
    }
  }
}
