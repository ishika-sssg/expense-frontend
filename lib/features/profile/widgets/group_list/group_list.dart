import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/navbar.dart';
import 'package:frontend/common/header.dart';
import 'package:frontend/features/profile/widgets/group_list/core/group_list_bloc.dart';
import 'package:frontend/features/profile/widgets/group_list/core/group_list_event.dart';
import 'package:frontend/features/profile/widgets/group_list/core/group_list_state.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';
import 'package:frontend/common/group_card.dart';

class GroupList extends StatefulWidget {
  // const GroupList({super.key});
  final String userName;
  final String userEmail;

  GroupList({required this.userName, required this.userEmail});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    // final result = _checkToken();
    // List<dynamic> groupList = [];

    return BlocProvider(
        lazy: false,
        create: (context) =>
        GroupListBloc(
          groupDetails: GroupDetails(),
          authStorage: AuthStorage(),
        )
          ..add(FetchUserGroups()),


        // From child : group list page

          // appBar: AppBar(title : Text("appbar")),


            child: BlocBuilder<GroupListBloc, GroupListState>(
                builder: (context, state) {
                  if (state is GroupListLoaded) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GroupListData) {
                    final groupData = state.groupsData;
                    var dataContent = groupData['data'];
                    var res = dataContent['alldata'];


                    return
                      Expanded(
                        child : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: groupData['data']['total'],
                          itemBuilder: (context, index) {
                            final group = groupData['data']['alldata'][index];
                            return GroupCard(group: group);
                          },
                        )

                      );
                  }
                  else{
                    return Center(
                        child : Text("from else")
                    );                  }
                })
        );



    // body: Scrollbar(
            //     thumbVisibility: true,
            //     child: SingleChildScrollView(
            //         child: Column(children: [
            //           BlocBuilder<GroupListBloc, GroupListState>(
            //               builder: (context, state) {
            //                 if (state is GroupListLoaded) {
            //                   return CircularProgressIndicator();
            //                 } else if (state is GroupListData) {
            //                   final groupData = state.groupsData;
            //                   print("in widget file $groupData");
            //
            //                   var dataContent = groupData['data'];
            //
            //                   // var res = dataContent['alldata'];
            //                   // print(res.runtimeType);
            //                   // return Center(child: GroupCard());
            //                   return Text("hii here");
            //
            //                   //   Expanded(
            //                   //     child :
            //                   //   ListView.builder(
            //                   //
            //                   //
            //                   //
            //                   //
            //                   //       scrollDirection: Axis.vertical,
            //                   //       shrinkWrap: true,
            //                   //       itemCount: groupData['data']['total'],
            //                   //       itemBuilder: (context, index) {
            //                   //         final group = groupData['data']['alldata'][index];
            //                   //
            //                   //         // return Center(child: GroupCard());
            //                   //         return GroupCard(group: group);
            //                   //         // return Center(child : Text("group card"));
            //                   //       }),
            //                   //
            //                   // );
            //                 } else {
            //                   // return Center(child: GroupCard());
            //                   return Center(child: Text("showing data error"));
            //                 }
            //               })
            //         ]
            //
            //
            //
            //         )
            //
            //
            //
            //
            //     ))));











  }
}
