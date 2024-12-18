import 'package:flutter/material.dart';
import 'package:jocco/core/utils/list_utils.dart';
import 'package:jocco/core/views/widgets/premium_page.dart';

class RecentLikes extends StatelessWidget {
  const RecentLikes({super.key});

  @override
  Widget build(BuildContext context) {
    return PremiumPage(data: firstPremiumData);
  }
}
