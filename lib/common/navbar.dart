import 'package:flutter/material.dart';

class CommonNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CommonNavbar({this.title = "Expense Management"});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
