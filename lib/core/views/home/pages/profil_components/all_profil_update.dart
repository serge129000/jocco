import 'package:flutter/material.dart';
import 'package:jocco/core/views/widgets/custom_uniform_scaffold.dart';

class AllProfilUpdate extends StatelessWidget {
  final Widget body;
  const AllProfilUpdate({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return CustomUniformScaffold(
      body: SafeArea(child: body),
    );
  }
}