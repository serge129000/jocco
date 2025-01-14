import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jocco/core/utils/all_text.dart';
import 'package:jocco/core/utils/color.dart';
import 'package:jocco/core/utils/path.dart';
import 'package:jocco/core/utils/screen.dart';
import 'package:jocco/core/views/providers/page_provider.dart';
import 'package:jocco/core/views/widgets/button.dart';
import 'package:provider/provider.dart';

class NoMatch extends StatelessWidget {
  const NoMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            kIconAssetPath(imageName: 'no_match.png'),
            height: 201,
            width: 257.48,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              AllText.findYourMatch,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold, color: PrimaryColors.white),
            ),
          ),
          Text(
            AllText.findPersProject,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w500, color: PrimaryColors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Consumer<PageProvider>(
                builder: (context, pageProvider, widgets) {
              return Btn(
                child: Text(
                  AllText.startMatch,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: PrimaryColors.first),
                ),
                isTransparent: false,
                function: () {
                  HapticFeedback.mediumImpact();
                  pageProvider.changePage(page: Pages.home);
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
