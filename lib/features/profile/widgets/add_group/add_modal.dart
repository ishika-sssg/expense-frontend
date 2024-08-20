import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/profile/widgets/add_group/core/add_group_bloc.dart';
import 'package:frontend/features/profile/widgets/add_group/core/add_group_event.dart';
import 'package:frontend/features/profile/widgets/add_group/core/add_group_state.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';
import 'package:auto_route/auto_route.dart';
import 'package:frontend/app/app_router.dart';

class AddModal extends StatefulWidget {
  const AddModal({super.key});

  @override
  State<AddModal> createState() => _AddModalState();
}

class _AddModalState extends State<AddModal> {
  final _formKey = GlobalKey<FormState>();

  final _gnameController = TextEditingController();
  final _gdescController = TextEditingController();
  String _selectedCategory = 'Bills';

  String? _nameError;
  String? _descError;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddGroupBloc(groupDetails: GroupDetails()),
      child: BlocConsumer<AddGroupBloc, AddGroupState>(
        builder: (context, state) {
          return AlertDialog(
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Create Group"),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                ),
              ),
              content: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // SizedBox(height: 16.0), // Space below the AppBar
                  TextFormField(
                    controller: _gnameController,
                    decoration: InputDecoration(
                      labelText: 'Group Name',
                      errorText: _nameError,
                    ),
                  ),
                  SizedBox(height: 16.0), // Space below the AppBar

                  TextFormField(
                    controller: _gdescController,
                    decoration: InputDecoration(
                      labelText: 'Group Description',
                      errorText: _descError,
                    ),
                  ),
                  SizedBox(height: 16.0),

                  DropdownButtonFormField(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Select Category',
                      ),
                      items: ['Bills', 'Food', 'Rent', 'Travel', 'Other']
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      }),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                      onPressed: () {
                        final gname = _gnameController.text;
                        final gdesc = _gdescController.text;
                        setState(() {
                          _nameError =
                              gname.isEmpty ? 'Please input group name' : null;
                          _descError =
                              gdesc.isEmpty ? 'Please input description' : null;
                        });
                        // print('email, password $email, $password');

                        //adding validation
                        if (gname.isNotEmpty && gdesc.isNotEmpty) {
                          context.read<AddGroupBloc>().add(
                                AddGroupSubmittedEvent(
                                  grp_name: gname,
                                  grp_desc: gdesc,
                                  grp_category: _selectedCategory,
                                ),
                              );
                        }
                      },
                      child: state is AddGroupLoaded
                          ? CircularProgressIndicator()
                          : Text('Create'))

                  // child: Text("Create"))
                ]),
              )));
        },
        listener: (context, state) {
          if (state is AddGroupSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Group created successfully'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1)),
            );

            //   directing to profile screen
            Future.delayed(Duration(seconds: 1), () async {
              final newval = state.newGroupData;
              print("from craete group modal $newval");
              final groupId = newval['data']['group']['ID'].toString();
              print('the id of group is $groupId');

              try {
                await AutoRouter.of(context).push(GroupDetailPageRoute(
                  groupId: groupId,
                  groupName: newval['data']['group']['group_name'],
                  groupDescription: newval['data']['group']['description'],
                  groupAdminId:
                      newval['data']['admin_details']['ID'].toString(),
                  groupAdminName: newval['data']['admin_details']['user_name'],
                ));
                // Navigator.of(context).pop(); // Close the dialog
              } catch (err) {
                print(err);
                return err;
              }
            });
          } else if (state is AddGroupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
      ),
    );
  }
}

// return AlertDialog(
//     title: Text("Create Group"),
//     content: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(mainAxisSize: MainAxisSize.min, children: [
//             SizedBox(height: 16.0), // Space below the AppBar
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Group Name',
//                 hintText: 'Enter group name',
//               ),
//             ),
//             SizedBox(height: 16.0), // Space below the AppBar
//
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Group Description',
//                 hintText: 'Enter group name',
//               ),
//             ),
//             SizedBox(height: 16.0), // Space below the AppBar
//
//             DropdownButtonFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Select Category',
//                 ),
//                 items: ['Bills', 'Food',  'Rent', 'Travel', 'Other']
//                     .map((category) => DropdownMenuItem(
//                   value: category,
//                   child: Text(category),
//                 ))
//                     .toList(),
//                 onChanged: (value) {}),
//             SizedBox(height: 16.0), // Space below the AppBar
//
//             ElevatedButton(
//                 onPressed: (){},
//                 child: Text("Create"))
//           ]),
//         )));
