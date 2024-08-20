import 'package:flutter/material.dart';
import 'package:frontend/app/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/navbar.dart';
import 'package:frontend/common/header.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/groupMembers/core/add_member_bloc.dart';
import 'package:frontend/features/groupMembers/core/add_member_event.dart';
import 'package:frontend/features/groupMembers/core/add_member_state.dart';

import 'package:frontend/features/viewAllMembers/view_all.dart';

import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';

@RoutePage()
class AddMemberPage extends StatefulWidget {
  final String groupId; // Declare groupId as an instance variable

  final String groupName;
  final String groupAdminId;
  final String groupAdminName;

  const AddMemberPage(
      {required this.groupId,
      required this.groupName,
      required this.groupAdminId,
      required this.groupAdminName,
      Key? key})
      : super(key: key);

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  // final AuthStorage _authStorage = AuthStorage();
  // final GroupDetails _groupDetails = GroupDetails();
  final TextEditingController emailController = TextEditingController();
  final List<dynamic> _addedMembers = []; // Initialize an empty list

  @override
  Widget build(BuildContext context) {
    print('the member list is $_addedMembers');

    return BlocProvider(
      create: (context) => AddMemberBloc(
          authStorage: AuthStorage(), groupDetails: GroupDetails())
        ..add(GetUserDetails()),
      child: Scaffold(
        appBar: CommonNavbar(),
        body: Container(
          child: Column(children: [
            // CustomHeader always present at the top
            BlocBuilder<AddMemberBloc, AddMemberState>(
              buildWhen: (previous, current) =>
                  current is GetUserDetailsSuccess,
              builder: (context, state) {
                if (state is GetUserDetailsSuccess) {
                  return Container(
                      child: Column(children: [
                    CustomHeader(
                      userName: state.userDetails["user_name"],
                      userEmail: state.userDetails["user_email"],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Add Members By Email',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ]));
                }
                return CustomHeader(
                  userName: "--",
                  userEmail: "--",
                );
              },
            ),

            // adding bloc consumer here :
            BlocConsumer<AddMemberBloc, AddMemberState>(
              builder: (context, state) {
                // return Text("hii");
                return Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded corners
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter email address',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.add, color: Colors.white),
                                  onPressed: () {
                                    final emailInput =
                                        emailController.text.trim();

                                    context.read<AddMemberBloc>().add(
                                        AddMemberByEmailEvent(
                                            member_email: emailInput,
                                            group_id: widget.groupId));
                                  },
                                ),
                              ),
                            ],
                          ),

                          // Show error message
                          if (state is AddMemberValidationError)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 5.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Please input email address",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (_addedMembers.isNotEmpty)
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: _addedMembers.length,
                        itemBuilder: (content, index) {
                          final member = _addedMembers[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            padding: EdgeInsets.all(10.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              border: Border.all(color: Colors.green),
                              borderRadius:
                                  BorderRadius.circular(5.0), // Rounded corners
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 2.0),
                                Text(
                                  '${member["data"]["details"]["MemberEmail"]}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text("Member Added"),
                              ],
                            ),
                          );
                        }),
                ]);
              },
              listener: (context, state) {
                if (state is AddMemberLoaded) {
                  CircularProgressIndicator();
                }
                if (state is AddMemberSuccess) {
                  setState(() {
                    _addedMembers.add(state.memberData);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Member Added Successfully"),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                if (state is AddMemberFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(" ${state.message}"),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
// Background color
                    ),
                  );
                }
              },
            ),
          ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.cyan,
          tooltip: 'View All Members',
          onPressed: () async {
            await AutoRouter.of(context).push(
              ViewAllRoute(
                  groupId: widget.groupId,
                  groupName: widget.groupName,
                  groupAdminId: widget.groupAdminId,
                  groupAdminName: widget.groupAdminName),
            );
          },
          label: Text(
            'View',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
          elevation: 6,
          icon: Icon(
            Icons.remove_red_eye,
            color: Colors.white,
          ),

          // child: const Icon(Icons.remove_red_eye, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
