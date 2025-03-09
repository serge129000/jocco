import 'package:flutter/material.dart';
import 'package:jocco/core/views/home/pages/profil_components/update_page.dart';
import 'package:jocco/core/views/widgets/custom_uniform_scaffold.dart';
import 'package:jocco/core/views/widgets/user_info_card.dart';
import 'package:provider/provider.dart';

import '../../../../utils/all_text.dart';
import '../../../../utils/color.dart';
import '../../../providers/auth_provider.dart';

class UpdateProfil extends StatefulWidget {
  const UpdateProfil({super.key});

  @override
  State<UpdateProfil> createState() => _UpdateProfilState();
}

class _UpdateProfilState extends State<UpdateProfil>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomUniformScaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: PrimaryColors.white),
        title: Text(
          AllText.updateProfil,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: PrimaryColors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Consumer<AppAuthProvider>(
                builder: (context, authProvider, widgets) {
              return TabBar(
                  onTap: (value) {},
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: PrimaryColors.white,
                  controller: tabController,
                  indicatorWeight: 3.5,
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        AllText.update,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: tabController.index == 0
                                ? FontWeight.bold
                                : null,
                            color: tabController.index == 0
                                ? Color(0xfff5f5f5)
                                : PrimaryColors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        AllText.preview,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: tabController.index == 1
                                ? FontWeight.bold
                                : null,
                            color: tabController.index == 1
                                ? Color(0xfff5f5f5)
                                : PrimaryColors.white),
                      ),
                    ),
                  ]);
            }),
          ),
          Expanded(
              child: Consumer<AppAuthProvider>(
                builder: (context, appAuthProvider, _) {
                  return TabBarView(
                      controller: tabController,
                      children: [UpdatePage(), Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 20
                        ),
                        child: UserInfoCard(user: appAuthProvider.currentAppUser!, controller: null, pageController: new PageController()),
                      )]);
                }
              ))
        ],
      ),
    );
  }
}
