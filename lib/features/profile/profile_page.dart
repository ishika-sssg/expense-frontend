import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/navbar.dart';
import 'package:frontend/common/header.dart';
import 'package:frontend/features/profile/core/profile_bloc.dart';
import 'package:frontend/features/profile/core/profile_event.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';
import 'package:frontend/repository/services/user_service/loggedin_user.dart';
import 'package:frontend/features/profile/core/profile_state.dart';
import '../profile/widgets/group_list/group_list.dart';
import '../profile/widgets/add_group/add_modal.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _formKey = GlobalKey<FormState>();
  final LoggedinUser loggedinUser = LoggedinUser();

  void _showCreateGroupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddModal();
        });
  }

  @override
  Widget build(BuildContext context) {
    // final result = _checkToken();

    return BlocProvider(
        lazy: false,
        create: (context) =>
        ProfileBloc(
          authStorage: AuthStorage(),
          groupDetails: GroupDetails(),
        )
          ..add(FetchUserDetails())
        ,
        child: Scaffold(
            appBar: CommonNavbar(),
            body:

            //     adding scroll here :
            Column(
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoaded) {


                        return Column(children: [
                          CustomHeader(
                              userName: state.user_name,
                              userEmail: state.email),
                          SizedBox(height: 10),
                          // Add some spacing between widgets
                        ]);
                      } else if (state is ProfileError) {
                        return CustomHeader(userName: '--', userEmail: '--');
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),

                  BlocConsumer<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileLoaded) {
                          return
                            Expanded(
                              child :
                              Column(
                                children: [
                                  // CustomHeader(
                                  //     userName: state.user_name,
                                  //     userEmail: state.email
                                  // ),
                                  // SizedBox(height: 10),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Your Groups",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  _showCreateGroupDialog(context);
                                                },
                                                child: Text('Add Group'),
                                              ),
                                            ],
                                          ),

                                          GroupList(userName: 'abc', userEmail: 'abc')

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )

                            );


                        // return Padding(
                        //   padding:
                        //   EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        //   child: Container(
                        //     height: MediaQuery.of(context).size.height -
                        //         100, // Adjust height as needed
                        //
                        //     child:
                        //
                        //     //     adding conatiner here
                        //     Container(
                        //         child :
                        //         Column(children: [
                        //           Row(
                        //             mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 "Your Groups",
                        //                 style: TextStyle(
                        //                     fontSize:
                        //                     16), // Customize the text style as needed
                        //               ),
                        //               ElevatedButton(
                        //                 onPressed: () {
                        //                   _showCreateGroupDialog(context);
                        //                 },
                        //                 child: Text('Add Group'),
                        //               ),
                        //             ],
                        //           ),
                        //           SizedBox(height: 8),
                        //           // Add spacing between Row and GroupList
                        //         ])),
                        //
                        //   ),
                        //
                        // );
                        } else {
                        return SizedBox.shrink();
                        }
                      },

                      // },
                      listener: (context, state) {}
                  ),

                  // Add GroupList widget here
                  // Expanded(child: GroupList(userName: 'abc', userEmail: 'abc')),
                  // GroupList(userName: 'abc', userEmail: 'abc'),

                  // Wrapping GroupList in a Container with a specific height might also help.
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.9, // Adjust height as needed
                  //   child: GroupList(userName: 'abc', userEmail: 'abc'),
                  // ),

                ]


            )
        )


    );
  }
}
