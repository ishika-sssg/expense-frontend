import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:frontend/app/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/bottom_navbar.dart';
import 'package:frontend/common/navbar.dart';
import 'package:frontend/common/header.dart';
import 'package:frontend/features/membersExpense/core/member_expense_bloc.dart';
import 'package:frontend/features/membersExpense/core/member_expense_state.dart';
import 'package:frontend/features/membersExpense/core/member_expense_event.dart';

import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/expense_service/expense_details.dart';

@RoutePage()
class MemberExpensePage extends StatefulWidget {
  const MemberExpensePage({super.key});

  @override
  State<MemberExpensePage> createState() => _MemberExpensePageState();
}

class _MemberExpensePageState extends State<MemberExpensePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MemberExpenseBloc(
        authStorage: AuthStorage(),
        expenseDetails: ExpenseDetails(),
      )..add(GetAllExpenseByMembersEvent()),
      child: Scaffold(
        appBar: CommonNavbar(),
        body: Padding(
          padding: EdgeInsets.all(0.0),
          child: //Column(
              //children: [
              BlocBuilder<MemberExpenseBloc, MemberExpenseState>(
            builder: (context, state) {
              if (state is GetMembersDetailsLoading) {
                return CircularProgressIndicator();
              }
              if (state is GetMembersDetailsSuccess) {
                // print("from friends page herer");
                // print(state.memberDetails);

                return Column(mainAxisSize: MainAxisSize.min, children: [
                  CustomHeader(
                    userName: state.userDetails["user_name"],
                    userEmail: state.userDetails["user_email"],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Members",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),

                    //   list of members :
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    // List of Members
                    child: ListView.builder(
                      shrinkWrap: true,

                      itemCount: state.memberDetails.data!.length,
                      itemBuilder: (context, index) {
                        final member = state.memberDetails.data[index];
                        return Column(children: [
                          Card(
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Padding(padding: EdgeInsets.all(16.0),

                                // adding clumn :
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                        mainAxisAlignment : MainAxisAlignment.start,
                                              children : [
                                            Icon(
                                              Icons.account_circle_rounded,
                                              color: Colors.cyan,
                                              size: 28.0,
                                            ),
                                            SizedBox(width: 8.0),
                                            Text(
                                              member.memberName,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                              ]
                                            )
                                          ],
                                        ),



                                        if (member.overallAmount == 0)
                                          Text(
                                            "No expenses",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.cyan,
                                            ),
                                          ),
                                        if (member.overallAmount < 0)
                                          Text(
                                            "you owes \n\S${member.overallAmount.abs().toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                            ),
                                          ),
                                        if (member.overallAmount > 0)
                                          Text(
                                            "owes you \n\S${member.overallAmount.abs().toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.green,
                                            ),
                                          ),
                                      ],
                                    ),


                                  ],
                                )


                                ),
                          ),

                          //   for details section :

                          if (member.pendingDetails != null &&
                              member.pendingDetails!.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 0.0,
                                  bottom: 0.0),
                              // Adds margin around the ConstrainedBox

                              padding: EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.transparent,
                                    blurRadius: 0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 2),
                                    ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minHeight: 100.0,
                                          maxHeight: 200.0,
                                        ),
                                        // SizedBox(

                                        child: Scrollbar(
                                          thumbVisibility: true,
                                          child: ListView.builder(
                                            itemCount: member.pendingDetails!.length,
                                            itemBuilder: (context, index) {
                                              final expense = member.pendingDetails![index];
                                              final loggedinuser = state.userDetails["user_id"];
                                              var balanceMsg;
                                              if (loggedinuser == expense.creditbyId)
                                                balanceMsg = Text("${expense.debtorName} owes you \$${expense.expenseAmount.toStringAsFixed(2)}",
                                                  style: TextStyle(color: Colors.green),
                                                );
                                              else {
                                                balanceMsg = Text("You owes ${expense.creditorName} \$${expense.expenseAmount.toStringAsFixed(2)}",
                                                  style: TextStyle(color: Colors.red),
                                                );
                                              }
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    leading: Icon(Icons.group,
                                                        color: Colors.cyan),
                                                    title: Text(expense.groupName),
                                                    subtitle: balanceMsg,

                                                    trailing: IconButton(
                                                        onPressed: () async {
                                                          //   sending rout to group detail page for settlement:
                                                          await AutoRouter.of(context).push(GroupDetailPageRoute(
                                                              groupId: expense.groupId.toString(),
                                                              groupName: expense.groupName,
                                                              groupDescription: expense.groupDesc,
                                                              groupAdminId: expense.groupAdminId.toString(),
                                                              groupAdminName: expense.groupAdminName ?? "not mentioned"));
                                                        },
                                                        icon: Icon(
                                                            Icons.remove_red_eye_rounded,
                                                            color: Colors.cyan)),


                                                  ),
                                                  Divider(),
                                                ],
                                              );
                                            },
                                          ),
                                        )),
                                  ]),
                            )
                        ]);
                      },
                    ),
                  ),
                ]);
              } else {
                return Text("in else blockhere ");
              }
            },
          ),

        ),
        bottomNavigationBar: BottomNavbar(),
      ),
    );
  }
}
