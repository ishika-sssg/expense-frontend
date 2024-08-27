import 'package:flutter/material.dart';

class CommonNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CommonNavbar({
    this.title = "Monefy",
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      // centerTitle: false,
      centerTitle: true,

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
