import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:frontend/app/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/bottom_navbar.dart';
import 'package:frontend/common/navbar.dart';
import 'package:frontend/common/header.dart';
import 'package:frontend/features/addExpense/core/add_expense_bloc.dart';
import 'package:frontend/features/addExpense/core/add_expense_event.dart';
import 'package:frontend/features/addExpense/core/add_expense_state.dart';
import 'package:frontend/repository/services/expense_service/expense_details.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';
import 'package:frontend/repository/models/expense.dart';

@RoutePage()
class AddExpensePage extends StatefulWidget {
  final String groupId; // Declare groupId as an instance variable

  final String groupName;
  final String groupAdminId;
  final String groupAdminName;

  const AddExpensePage(
      {required this.groupId,
      required this.groupName,
      required this.groupAdminId,
      required this.groupAdminName,
      Key? key})
      : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  List<dynamic> _selectedMembers = [];
  List<DropdownMenuItem<dynamic>> _paidByItems = [];
  dynamic _selectedPaidByMember;

  String? _expenseError;
  String? _amountError;
  String? _paidbyError;
  String? _selectMemberError;

  String _expenseName = '';
  String _description = '';
  double _amount = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddExpenseBloc(
            authStorage: AuthStorage(),
            groupDetails: GroupDetails(),
            expenseDetails: ExpenseDetails())
          ..add(GetUserDetails())
          ..add(FetchAllGroupMembersEvent(widget.groupId)),
        child: Scaffold(
            appBar: CommonNavbar(),
            body: Container(

                // adding scrollbar :
              child : SingleChildScrollView(

                child: Column(children: [
              // CustomHeader always present at the top
              BlocBuilder<AddExpenseBloc, AddExpenseState>(
                buildWhen: (previous, current) =>
                    current is GetProfileUserDetails,
                builder: (context, state) {
                  if(state is AddExpenseLoaded){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is GetProfileUserDetails) {
                    return Container(
                        child: Column(children: [
                      CustomHeader(
                        userName: state.userDetails["user_name"],
                        userEmail: state.userDetails["user_email"],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Add Expense',
                        style: TextStyle(
                          fontSize: 20.0, // Adjust the font size as needed
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ]));
                  }
                  return CustomHeader(
                    userName: "--",
                    userEmail: "--",
                  ); // Provide default values if state is not loaded yet
                },
              ),

              //       form start here
              BlocConsumer<AddExpenseBloc, AddExpenseState>(
                  buildWhen: (previous, current) =>
                      current is GetAllGroupMembersState,
                  builder: (context, state) {

                    if (state is GetAllGroupMembersState) {
                      List<MultiSelectItem<dynamic>> items = state
                          .allMembersData
                          .map<MultiSelectItem<dynamic>>((member) {
                        return MultiSelectItem<dynamic>(
                          member['member_id'],
                          member["member_name"] ?? 'Unknown',
                        );
                      }).toList();

                      //list for the 'Paid By' dropdown
                      List<DropdownMenuItem<dynamic>> paidByItems = state
                          .allMembersData
                          .map<DropdownMenuItem<dynamic>>((member) {
                        return DropdownMenuItem<dynamic>(
                          value: member['member_id'],
                          child: Text(member["member_name"] ?? 'Unknown'),
                        );
                      }).toList();

                      print("the list of selected members is");
                      print(_selectedMembers);

                      return

                          // Padding(
                          // padding: const EdgeInsets.all(16.0),
                          // child: Form(
                          Form(
                              key: _formKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(children: [
                                          // Text("form here"),
                                          // Multi-select dropdown for members
                                          MultiSelectDialogField<dynamic>(
                                            items: items,
                                            title: Text("Members"),
                                            selectedColor: Colors.green,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              border: Border.all(
                                                color: Colors.blue,
                                                width: 2,
                                              ),
                                            ),
                                            buttonIcon: Icon(
                                              Icons.group,
                                              color: Colors.blue,
                                            ),
                                            buttonText: Text(
                                              "Select Members",
                                              style: TextStyle(
                                                color: Colors.blue[800],
                                                fontSize: 16,
                                              ),
                                            ),
                                            onConfirm: (List<dynamic>
                                                selectedMembers) {
                                              setState(() {
                                                _selectedMembers =
                                                    selectedMembers;
                                                _paidByItems = selectedMembers.map<DropdownMenuItem<dynamic>>((memberId) {
                                                  final selectedMember = state.allMembersData.firstWhere((member) => member['member_id'] == memberId);
                                                  return DropdownMenuItem<
                                                      dynamic>(
                                                    value: selectedMember[
                                                        'member_id'],
                                                    child: Text(selectedMember[
                                                            "member_name"] ??
                                                        'Unknown'),
                                                  );
                                                }).toList();

                                                // If the currently selected "Paid By" member is removed, reset it
                                                if (_selectedPaidByMember !=
                                                        null &&
                                                    !_selectedMembers.contains(
                                                        _selectedPaidByMember)) {
                                                  _selectedPaidByMember = null;
                                                }
                                              });
                                            },
                                            chipDisplay: MultiSelectChipDisplay(
                                              onTap: (dynamic member) {
                                                setState(() {
                                                  _selectedMembers
                                                      .remove(member);
                                                  _paidByItems.removeWhere(
                                                      (item) =>
                                                          item.value == member);
                                                  // If the removed member was selected as "Paid By", reset it
                                                  if (_selectedPaidByMember ==
                                                      member) {
                                                    _selectedPaidByMember =
                                                        null;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 20),

                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Expense Name',
                                              errorText: _expenseError,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter an expense name';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _expenseName = value!;
                                            },
                                          ),
                                          SizedBox(height: 16.0),

                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Description',
                                            ),
                                            onSaved: (value) {
                                              // Save the expense name
                                              _description = value!;
                                            },
                                          ),
                                          SizedBox(height: 16.0),

                                          // TextFormField for Amount
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Amount',
                                              errorText: _amountError,
                                            ),
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter the amount';
                                              }
                                              if (double.tryParse(value) ==
                                                  null) {
                                                return 'Please enter a valid number';
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              _amount = double.parse(value!);
                                            },
                                          ),
                                          SizedBox(height: 16.0),

                                          // Dropdown for "Paid By"
                                          DropdownButtonFormField<dynamic>(
                                            decoration: InputDecoration(
                                              labelText: 'Paid By',
                                              errorText: _paidbyError,
                                            ),
                                            items: _paidByItems,
                                            value: _selectedPaidByMember,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedPaidByMember = value;
                                              });
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select who paid';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 16.0),

                                          // Create Button
                                          ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();

                                                final List<int> membersList =
                                                    _selectedMembers
                                                        .map((member) {
                                                  if (member is String) {
                                                    return int.parse(member);
                                                  } else if (member is int) {
                                                    return member;
                                                  } else {
                                                    throw ArgumentError(
                                                        'Invalid member type');
                                                  }
                                                }).toList();

                                                final expenseResponse = Expense(
                                                  expenseName: _expenseName,
                                                  description: _description,
                                                  amount: _amount,
                                                  paidBy: _selectedPaidByMember,
                                                  members: membersList,
                                                  group_id: widget.groupId,
                                                );
                                                context.read<AddExpenseBloc>().add(AddExpenseOnClick(expenseResponse));
                                              }
                                            },
                                            child: Text('Create Expense'),
                                            // child : isLoading ? CircularProgressIndicator() : Text("Create Expense")
                                          ),
                                        ]))
                                  ]));
                      // );
                    }
                    return Center(
                      child : Column(

                        children : [
                      Padding(
                      padding: const EdgeInsets.all(16.0),

                        child : Text(
                              "No Group Members Added. \nPlease add members in group before creating expense.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        )
                      ),
                          // ElevatedButton(
                          //     onPressed: (){},
                          //     child: Text("Add Members"))
                        ]
                      )





                    );
                  },
                  listener: (context, state) {
                    if(state is AddExpenseLoadingState){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Adding expense')),
                      );
                    }
                    if (state is AddExpenseSubmittedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Expense created successfully'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Navigate to another page after showing the message
                      Future.delayed(Duration(seconds: 2), () async {
                        await AutoRouter.of(context).push(GroupDetailPageRoute(
                            groupId: widget.groupId,
                            groupName: widget.groupName,
                            groupDescription: "",
                            groupAdminId: widget.groupAdminId,
                            groupAdminName: widget.groupAdminName));
                      });
                    } else if (state is AddExpenseErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ));
                    }
                  })
            ]
                )

    )
            ),

          bottomNavigationBar: BottomNavbar(),

        )
    );
  }
}
