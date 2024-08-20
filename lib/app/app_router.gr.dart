// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddExpensePage]
class AddExpensePageRoute extends PageRouteInfo<AddExpensePageRouteArgs> {
  AddExpensePageRoute({
    required String groupId,
    required String groupName,
    required String groupAdminId,
    required String groupAdminName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AddExpensePageRoute.name,
          args: AddExpensePageRouteArgs(
            groupId: groupId,
            groupName: groupName,
            groupAdminId: groupAdminId,
            groupAdminName: groupAdminName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddExpensePageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddExpensePageRouteArgs>();
      return AddExpensePage(
        groupId: args.groupId,
        groupName: args.groupName,
        groupAdminId: args.groupAdminId,
        groupAdminName: args.groupAdminName,
        key: args.key,
      );
    },
  );
}

class AddExpensePageRouteArgs {
  const AddExpensePageRouteArgs({
    required this.groupId,
    required this.groupName,
    required this.groupAdminId,
    required this.groupAdminName,
    this.key,
  });

  final String groupId;

  final String groupName;

  final String groupAdminId;

  final String groupAdminName;

  final Key? key;

  @override
  String toString() {
    return 'AddExpensePageRouteArgs{groupId: $groupId, groupName: $groupName, groupAdminId: $groupAdminId, groupAdminName: $groupAdminName, key: $key}';
  }
}

/// generated route for
/// [AddMemberPage]
class AddMemberPageRoute extends PageRouteInfo<AddMemberPageRouteArgs> {
  AddMemberPageRoute({
    required String groupId,
    required String groupName,
    required String groupAdminId,
    required String groupAdminName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AddMemberPageRoute.name,
          args: AddMemberPageRouteArgs(
            groupId: groupId,
            groupName: groupName,
            groupAdminId: groupAdminId,
            groupAdminName: groupAdminName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddMemberPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddMemberPageRouteArgs>();
      return AddMemberPage(
        groupId: args.groupId,
        groupName: args.groupName,
        groupAdminId: args.groupAdminId,
        groupAdminName: args.groupAdminName,
        key: args.key,
      );
    },
  );
}

class AddMemberPageRouteArgs {
  const AddMemberPageRouteArgs({
    required this.groupId,
    required this.groupName,
    required this.groupAdminId,
    required this.groupAdminName,
    this.key,
  });

  final String groupId;

  final String groupName;

  final String groupAdminId;

  final String groupAdminName;

  final Key? key;

  @override
  String toString() {
    return 'AddMemberPageRouteArgs{groupId: $groupId, groupName: $groupName, groupAdminId: $groupAdminId, groupAdminName: $groupAdminName, key: $key}';
  }
}

/// generated route for
/// [GroupDetailPage]
class GroupDetailPageRoute extends PageRouteInfo<GroupDetailPageRouteArgs> {
  GroupDetailPageRoute({
    required String groupId,
    required String groupName,
    required String groupDescription,
    required String groupAdminId,
    required String groupAdminName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          GroupDetailPageRoute.name,
          args: GroupDetailPageRouteArgs(
            groupId: groupId,
            groupName: groupName,
            groupDescription: groupDescription,
            groupAdminId: groupAdminId,
            groupAdminName: groupAdminName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'GroupDetailPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GroupDetailPageRouteArgs>();
      return GroupDetailPage(
        groupId: args.groupId,
        groupName: args.groupName,
        groupDescription: args.groupDescription,
        groupAdminId: args.groupAdminId,
        groupAdminName: args.groupAdminName,
        key: args.key,
      );
    },
  );
}

class GroupDetailPageRouteArgs {
  const GroupDetailPageRouteArgs({
    required this.groupId,
    required this.groupName,
    required this.groupDescription,
    required this.groupAdminId,
    required this.groupAdminName,
    this.key,
  });

  final String groupId;

  final String groupName;

  final String groupDescription;

  final String groupAdminId;

  final String groupAdminName;

  final Key? key;

  @override
  String toString() {
    return 'GroupDetailPageRouteArgs{groupId: $groupId, groupName: $groupName, groupDescription: $groupDescription, groupAdminId: $groupAdminId, groupAdminName: $groupAdminName, key: $key}';
  }
}

/// generated route for
/// [LoginPage]
class LoginPageRoute extends PageRouteInfo<void> {
  const LoginPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfilePageRoute extends PageRouteInfo<void> {
  const ProfilePageRoute({List<PageRouteInfo>? children})
      : super(
          ProfilePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfilePageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [SettleupPage]
class SettleupPageRoute extends PageRouteInfo<SettleupPageRouteArgs> {
  SettleupPageRoute({
    required String groupId,
    required String groupName,
    required String groupDescription,
    required String groupAdminId,
    required String groupAdminName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SettleupPageRoute.name,
          args: SettleupPageRouteArgs(
            groupId: groupId,
            groupName: groupName,
            groupDescription: groupDescription,
            groupAdminId: groupAdminId,
            groupAdminName: groupAdminName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SettleupPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SettleupPageRouteArgs>();
      return SettleupPage(
        groupId: args.groupId,
        groupName: args.groupName,
        groupDescription: args.groupDescription,
        groupAdminId: args.groupAdminId,
        groupAdminName: args.groupAdminName,
        key: args.key,
      );
    },
  );
}

class SettleupPageRouteArgs {
  const SettleupPageRouteArgs({
    required this.groupId,
    required this.groupName,
    required this.groupDescription,
    required this.groupAdminId,
    required this.groupAdminName,
    this.key,
  });

  final String groupId;

  final String groupName;

  final String groupDescription;

  final String groupAdminId;

  final String groupAdminName;

  final Key? key;

  @override
  String toString() {
    return 'SettleupPageRouteArgs{groupId: $groupId, groupName: $groupName, groupDescription: $groupDescription, groupAdminId: $groupAdminId, groupAdminName: $groupAdminName, key: $key}';
  }
}

/// generated route for
/// [SignupPage]
class SignupPageRoute extends PageRouteInfo<void> {
  const SignupPageRoute({List<PageRouteInfo>? children})
      : super(
          SignupPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignupPage();
    },
  );
}

/// generated route for
/// [ViewAll]
class ViewAllRoute extends PageRouteInfo<ViewAllRouteArgs> {
  ViewAllRoute({
    required String groupId,
    required String groupName,
    required String groupAdminId,
    required String groupAdminName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ViewAllRoute.name,
          args: ViewAllRouteArgs(
            groupId: groupId,
            groupName: groupName,
            groupAdminId: groupAdminId,
            groupAdminName: groupAdminName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewAllRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewAllRouteArgs>();
      return ViewAll(
        groupId: args.groupId,
        groupName: args.groupName,
        groupAdminId: args.groupAdminId,
        groupAdminName: args.groupAdminName,
        key: args.key,
      );
    },
  );
}

class ViewAllRouteArgs {
  const ViewAllRouteArgs({
    required this.groupId,
    required this.groupName,
    required this.groupAdminId,
    required this.groupAdminName,
    this.key,
  });

  final String groupId;

  final String groupName;

  final String groupAdminId;

  final String groupAdminName;

  final Key? key;

  @override
  String toString() {
    return 'ViewAllRouteArgs{groupId: $groupId, groupName: $groupName, groupAdminId: $groupAdminId, groupAdminName: $groupAdminName, key: $key}';
  }
}
