import 'package:flutter/material.dart';
import 'package:frontend/app/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:frontend/repository/models/all_groups_data.dart';



class GroupCard extends StatefulWidget {
  // const GroupCard({super.key});
  // final Map<String, dynamic> group;

  final Alldata group;

  GroupCard({required this.group});


  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {

  @override
  Widget build(BuildContext context) {

    return
       GestureDetector(
    onTap : () async{
    await AutoRouter.of(context).push(GroupDetailPageRoute(
    // groupId: widget.group['ID'].toString(),
    //   groupName: widget.group['group_name'],
    //   groupDescription: widget.group['description'],
    //   groupAdminId: widget.group['group_admin_id'].toString(),
    //   groupAdminName: widget.group['admin']['user_name']

        groupId: widget.group.iD.toString(),
        groupName: widget.group.groupName!,
        groupDescription: widget.group.description!,
        groupAdminId: widget.group.groupAdminId.toString(),
        groupAdminName: widget.group.admin?.userName ?? "not mentioned"



    ));

    },



    child : Container(
      width: double.infinity,
      // This makes the width of the Container full screen

      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                  Text(
                    // widget.group['group_name'],
                    widget.group.groupName!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    // widget.group['category'],
                    widget.group.category!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                ]

              ),

              SizedBox(height: 8),
              Text(
                // widget.group['description'],
                 widget.group.description!,

              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 8),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children : [
                  Text('Admin : ',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),

                    Text(
                    // widget.group["admin"]["user_name"],
                        widget.group.admin?.userName ?? "not mentioned",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ]
              )

            ],
          ),
        ),

        ),
      ),
       );


  }
}
