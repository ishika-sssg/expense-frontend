import 'package:flutter/material.dart'; // Import this for Key and other material widgets
import 'package:auto_route/auto_route.dart';
import 'package:frontend/features/profile/profile_page.dart';
import 'package:frontend/features/signup/signup_page.dart';
import 'package:frontend/features/login/login_page.dart';
import 'package:frontend/features/group/group_detail.dart';
import 'package:frontend/features/groupMembers/add_member_page.dart';
import 'package:frontend/features/viewAllMembers/view_all.dart';
import 'package:frontend/features/addExpense/add_expense_page.dart';
import 'package:frontend/features/settleup/settleup_page.dart';
import 'package:frontend/features/viewSettlements/view_settlement_page.dart';
import 'package:frontend/features/membersExpense/member_expense_page.dart';
import 'package:frontend/features/account/account_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Route")
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        // AutoRoute(page: SignupPage, initial: true)
        AutoRoute(
          page: SignupPageRoute.page,
          // path: '/',
          initial: true,
        ),
        AutoRoute(page: ProfilePageRoute.page),
        AutoRoute(page: LoginPageRoute.page),
        AutoRoute(page: GroupDetailPageRoute.page, path: '/group/:groupId'),
        // Dynamic route for GroupDetailPage
        AutoRoute(
            page: AddMemberPageRoute.page, path: '/group/add_member/:groupId'),
        // AutoRoute(
        //     page: AddMemberPageRoute.page, path: '/group/add_member/:groupId'),
        AutoRoute(page: ViewAllRoute.page, path: '/group/viewall/:groupId'),
        AutoRoute(page: AddExpensePageRoute.page, path: '/addexpense/'),
        AutoRoute(page: SettleupPageRoute.page, path: '/settleup'),
        AutoRoute(page: ViewSettlementPageRoute.page),
        AutoRoute(page: MemberExpensePageRoute.page),
          AutoRoute(page: AccountPageRoute.page),

  ];
}
