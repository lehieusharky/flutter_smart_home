import 'package:animation/utils/helper/text_style_helper.dart';
import 'package:flutter/material.dart';

class BasicAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget>? action;
  final Widget? leading;

  const BasicAppBar({super.key, this.leading, this.action});

  @override
  State<StatefulWidget> createState() => _BasicAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _BasicAppBarState extends State<BasicAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 60,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: widget.leading,
      actions: widget.action,
      title: Text(
        'SRemote',
        style: TextStyleHelper.titleAppBar,
      ),
    );
  }
}
