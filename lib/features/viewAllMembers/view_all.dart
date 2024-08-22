import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/bottom_navbar.dart';

import 'package:frontend/features/viewAllMembers/core/view_all_bloc.dart';
import 'package:frontend/features/viewAllMembers/core/view_all_event.dart';
import 'package:frontend/features/viewAllMembers/core/view_all_state.dart';

import 'package:frontend/common/navbar.dart';
import 'package:frontend/common/header.dart';

import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';

@RoutePage()
class ViewAll extends StatefulWidget {
  final String groupId; // Declare groupId as an instance variable

  final String groupName;
  final String groupAdminId;
  final String groupAdminName;

  const ViewAll(
      {required this.groupId,
      required this.groupName,
      required this.groupAdminId,
      required this.groupAdminName,
      Key? key})
      : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  @override
  Widget build(BuildContext context) {
    print(widget.groupId);
    return BlocProvider(
        create: (context) => ViewAllBloc(
            authStorage: AuthStorage(), groupDetails: GroupDetails())
          ..add(GetAllMembersEvent(group_id: widget.groupId)),
        child: Scaffold(
            appBar: CommonNavbar(),
            body: Padding(
                padding: EdgeInsets.all(0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocListener<ViewAllBloc, ViewAllState>(
                        listener: (context, state) {
                          if (state is MemberDeleteSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Member deleted successfully'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else if (state is AdminOnlyDeleteError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${state.message}'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else if (state is MemberDeleteFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<ViewAllBloc, ViewAllState>(
                            buildWhen: (previous, current) =>
                                current is ViewAllMembersSuccess,
                            builder: (context, state) {
                              if (state is ViewAllMembersSuccess) {
                                return Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      CustomHeader(
                                        userName: state.userData["user_name"],
                                        userEmail: state.userData["user_email"],
                                      ),
                                      SizedBox(height: 16.0),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'All Members',
                                          style: TextStyle(
                                            fontSize:
                                                20.0, // Adjust the font size as needed
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                widget.groupName,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              // Text(
                                              //   'Admin : ${widget.groupAdminName}',
                                              //   style: TextStyle(color: Colors.cyan, fontSize: 18),
                                              // )
                                            ]),
                                        // Add Members button
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: state
                                              .membersData["data"]["details"]
                                              .length,
                                          itemBuilder: (context, index) {
                                            final member =
                                                state.membersData["data"]
                                                    ["details"][index];
                                            final member_id = state
                                                .membersData["data"]["details"]
                                                    [index]["member_id"]
                                                .toString();

                                            // print("member id is here $member_id");
                                            // print("loggedin user ${widget.}")

                                            // return ListTile(title : Text("hii"));
                                            return Card(
                                              elevation: 3,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal: 16.0),
                                              child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 8.0,
                                                          horizontal: 16.0),
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        member["member_name"],
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4.0),
                                                      Text(
                                                        member["member_email"],
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        if (member[
                                                                "is_admin"] ==
                                                            true)
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        4),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.cyan,
                                                              // Background color of the badge
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12), // Rounded corners
                                                            ),
                                                            child: Text(
                                                              "Admin",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                // Text color
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.red),
                                                          onPressed: () {
                                                            // Handle the delete action
                                                            // print("button clicked");
                                                            context
                                                                .read<
                                                                    ViewAllBloc>()
                                                                .add(DeleteMemberEvent(
                                                                    group_id: widget
                                                                        .groupId,
                                                                    member_id:
                                                                        member_id,
                                                                    group_admin_id:
                                                                        widget
                                                                            .groupAdminId));
                                                          },
                                                        ),
                                                      ])),
                                            );
                                          },
                                        ),
                                      ),
                                    ]));
                              }
                              // return Text("in else");
                              else if (state is ViewAllMembersFailure) {
                                return Center(
                                  child: Text(
                                    "No members found",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      // Make the text bold
                                      color: Colors
                                          .cyan, // Adjust the font size as needed
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "No members found",
                                    style: TextStyle(
                                      fontSize:
                                          20.0, // Adjust the font size as needed
                                    ),
                                  ),
                                );
                              }
                            }),
                      )
                    ])
            ),

          bottomNavigationBar: BottomNavbar(),

        )
    );
  }
}
