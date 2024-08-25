import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:frontend/app/app_router.dart';


class BottomNavbar extends StatefulWidget {

  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {

 int  _selectedIndex = 0;
  void _onItemTapped(BuildContext context, int index) {
    // final tabsRouter = AutoTabsRouter.of(context);

    setState(() {
      _selectedIndex = index;
      // tabsRouter.setActiveIndex(index);
    });

    switch (index) {
      case 0:
      AutoRouter.of(context).replace(ProfilePageRoute()); // Navigate using AutoRoute
      //   tabsRouter.navigate(ProfilePageRoute());
      break;
      case 1:
      AutoRouter.of(context).replace(MemberExpensePageRoute()); // Example with a groupId
      break;
      // case 2:
      // AutoRouter.of(context).push(ViewAllRoute(groupId: '1')); // Another example
      // break;
      case 2:
      AutoRouter.of(context).replace(ViewSettlementPageRoute()); // Navigate to
      //   tabsRouter.navigate(ViewSettlementPageRoute());
      break;
      case 3:
        AutoRouter.of(context).replace(AccountPageRoute()); // Navigate to
        //   tabsRouter.navigate(ViewSettlementPageRoute());
        break;
    }
  }


    @override
  Widget build(BuildContext context) {
      // final tabsRouter = AutoTabsRouter.of(context);

      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
        // currentIndex: tabsRouter.activeIndex, // Set the current index

        onTap: (index) => _onItemTapped(context, index),
      selectedItemColor: Colors.cyan,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.groups_rounded),
          label: 'Groups',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Friends',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
    );
  }
}
