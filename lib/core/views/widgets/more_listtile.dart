import 'package:flutter/material.dart';

class MoreListtile extends StatelessWidget {
  final String listTileText;
  final void Function() onTap;
  const MoreListtile({super.key, required this.listTileText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff003d3d),
      child: ListTile(
        onTap: onTap,
        title: Center(
          child: Text(
            listTileText,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Color(0xffff7070)
            ),
          ),
        ),
      ),
    );
  }
}
