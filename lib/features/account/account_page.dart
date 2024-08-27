import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frontend/app/app_router.dart';

import 'package:frontend/common/header.dart';
import 'package:frontend/common/navbar.dart';
import 'package:frontend/common/bottom_navbar.dart';

import 'package:frontend/features/account/core/account_bloc.dart';
import 'package:frontend/features/account/core/account_state.dart';
import 'package:frontend/features/account/core/account_event.dart';

import 'package:frontend/repository/services/auth_service/auth_storage.dart';

@RoutePage()
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AuthStorage _authStorage = AuthStorage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AccountBloc(
              authStorage: AuthStorage(),
            )..add(GetLoggedInUserDetails()),
        child: Scaffold(
          appBar: CommonNavbar(),
          body: Padding(
              padding: EdgeInsets.all(0.0),
              child: BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                if (state is GetUserDetailsLoading) {
                  return CircularProgressIndicator();
                }
                if (state is GetUserDetailsSuccess) {
                  print("from friends page herer");
                  print(state.userDetails);

                  return Column(mainAxisSize: MainAxisSize.min, children: [
                    CustomHeader(
                      userName: state.userDetails["user_name"],
                      userEmail: state.userDetails["user_email"],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),

                    // User Details Card
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // User name
                                  ListTile(
                                    leading: Icon(Icons.account_circle_rounded,
                                        color: Colors.cyan),
                                    title: Text(
                                      'User',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      state.userDetails["user_name"]
                                              .toUpperCase() ??
                                          '********', // Use a placeholder if password isn't fetched
                                    ),
                                  ),
                                  Divider(),

                                  // User email
                                  ListTile(
                                    leading:
                                        Icon(Icons.email, color: Colors.cyan),
                                    title: Text(
                                      'Email',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle:
                                        Text(state.userDetails["user_email"]),
                                  ),
                                  Divider(),

                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      await _authStorage.clearAll();
                                      //   delete token
                                      await _authStorage.deleteToken("token");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text("Logged out successfully"),
                                          backgroundColor: Colors.green,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      //   sending rout to group detail page for settlement:
                                      await AutoRouter.of(context)
                                          .replace(LoginPageRoute());
                                    },
                                    icon:
                                        Icon(Icons.logout, color: Colors.white),
                                    label: Text(
                                      "LOG OUT",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[400],
                                      // Background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        )),
                  ]);
                }
                return Text("Fetching user details");
              })),
          bottomNavigationBar: BottomNavbar(),
        ));
  }
}
