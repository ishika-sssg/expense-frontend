import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:frontend/app/app_router.dart';
import 'package:frontend/common/navbar.dart';
import 'package:frontend/common/header.dart';
import 'package:frontend/features/group/core/group_detail_bloc.dart';
import 'package:frontend/features/group/core/group_detail_event.dart';
import 'package:frontend/features/group/core/group_detail_state.dart';
import 'package:frontend/features/settleup/settleup_page.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/group_service/group_details.dart';

@RoutePage()
class GroupDetailPage extends StatefulWidget {
  // const GroupDetailPage({ super.key});
  final String groupId; // Declare groupId as an instance variable

  final String groupName;
  final String groupDescription;
  final String groupAdminId;
  final String groupAdminName;

  const GroupDetailPage(
      {required this.groupId,
      required this.groupName,
      required this.groupDescription,
      required this.groupAdminId,
      required this.groupAdminName,
      Key? key})
      : super(key: key);

  @override
  State<GroupDetailPage> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupDetailBloc(
        authStorage: AuthStorage(),
        groupDetails: GroupDetails(),
      )..add(GetUserDetails(group_id: widget.groupId)),
      child: Scaffold(
        appBar: CommonNavbar(),
        body: BlocListener<GroupDetailBloc, GroupDetailState>(
          listener: (context, state) {
            if (state is GetUserDetailsSuccess) {
              //
              // context.read<GroupDetailBloc>().add(
              //       GetAllExpensesEvent(group_id: widget.groupId),
              //     );
              print("yesss");
            }
          },
          child: Column(
            children: [
              // BlocBuilder for custom header
              BlocBuilder<GroupDetailBloc, GroupDetailState>(
                builder: (context, state) {
                  if (state is GetUserDetailsSuccess) {
                    return CustomHeader(
                      userName: state.userDetails["user_name"],
                      userEmail: state.userDetails["user_email"],
                    );
                  }
                  return CustomHeader(
                    userName: "--",
                    userEmail: "--",
                  );
                },
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.groupName,
                      style: TextStyle(fontSize: 20),
                    ),
                    // Text(
                    //   'Admin : ${widget.groupAdminName}',
                    //   style: TextStyle(color: Colors.cyan, fontSize: 18),
                    // ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await AutoRouter.of(context).push(
                            SettleupPageRoute(
                              groupId: widget.groupId,
                              groupName: widget.groupName,
                              groupAdminId: widget.groupAdminId,
                              groupAdminName: widget.groupAdminName,
                              groupDescription: widget.groupDescription,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan, // Background color
                          foregroundColor: Colors.white, // Text color
                        ),
                        child: Text("Settle Up"),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          await AutoRouter.of(context).push(
                            AddMemberPageRoute(
                              groupId: widget.groupId,
                              groupName: widget.groupName,
                              groupAdminId: widget.groupAdminId,
                              groupAdminName: widget.groupAdminName,
                            ),
                          );
                        },
                        child: Text("Add Members"),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          await AutoRouter.of(context).push(
                            AddExpensePageRoute(
                              groupId: widget.groupId,
                              groupName: widget.groupName,
                              groupAdminId: widget.groupAdminId,
                              groupAdminName: widget.groupAdminName,
                            ),
                          );
                        },
                        child: Text("Add Expense"),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        child: Text("View Members"),
                        onPressed: () async {
                          await AutoRouter.of(context).push(
                            ViewAllRoute(
                              groupId: widget.groupId,
                              groupName: widget.groupName,
                              groupAdminId: widget.groupAdminId,
                              groupAdminName: widget.groupAdminName,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          await AutoRouter.of(context).push(
                            ProfilePageRoute(),
                            //
                            // AddExpensePageRoute(
                            //   groupId: widget.groupId,
                            //   groupName: widget.groupName,
                            //   groupAdminId: widget.groupAdminId,
                            //   groupAdminName: widget.groupAdminName,
                            // ),
                          );
                        },
                        child: Text("View Settlements"),
                      ),
                    ],
                  ),
                ),
              ),
              // BlocBuilder for expense list
              Expanded(
                child: BlocBuilder<GroupDetailBloc, GroupDetailState>(
                  builder: (context, state) {
                    if (state is GetUserDetailsSuccess) {
                      if (state.expenseDetails["total"] == 0)
                        return Text("No expense yet",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ));

                      // Display the list of expenses

                      return Column(children: [
                        // Summary widget
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.all(5.0),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (state.expenseSummary["summary"]
                                          ["total_lent"] >
                                      state.expenseSummary["summary"]
                                          ["total_borrowed"])
                                    Text(
                                      'You are owed \$${state.expenseSummary["summary"]["net_balance"].toStringAsFixed(2)} overall',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  if (state.expenseSummary["summary"]
                                          ["total_lent"] <
                                      state.expenseSummary["summary"]
                                          ["total_borrowed"])
                                    Text(
                                      'You owe \$${state.expenseSummary["summary"]["net_balance"].toStringAsFixed(2)} overall',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  SizedBox(height: 5.0),

                                  // Displaying each user detail

                                  if (state.expenseSummary["overall_details"] ==
                                      null)
                                    Text("NO PENDING RECORDS TO SETTLE")
                                  else
                                    ...state.expenseSummary["overall_details"]
                                        .map<Widget>((detail) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${detail["user_name"]}',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 10.0),
                                                Text(
                                                  detail["status"] ==
                                                          "needs to pay"
                                                      ? "owes"
                                                      : "owes you",

                                                  style: TextStyle(
                                                    fontSize: 14.0,

                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '\$${detail["net_amount"].toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: detail["status"] ==
                                                        "needs to pay"
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: ListView.builder(
                            itemCount: state.expenseDetails["total"],
                            itemBuilder: (context, index) {
                              final expense =
                                  state.expenseDetails["shareinfo"][index];

                              return Card(
                                  margin: EdgeInsets.all(10.0),
                                  child: Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: Colors.cyan,
                                            size: 24.0,
                                          ),
                                          SizedBox(width: 10.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  expense["expense_name"],
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  // expense.isBorrowed ? 'Borrowed' : 'Owned',
                                                  "${expense["paid_by"]["user_name"]} paid \$${expense["amount"].toStringAsFixed(2)}",
                                                  style: TextStyle(
                                                    // color: expense.isBorrowed
                                                    // ? Colors.red
                                                    //     : Colors.green,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (expense["user_owed"] > 0)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '\$${expense["user_owed"].toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  // expense.isBorrowed ? 'Borrowed' : 'Owned',
                                                  "you lent",
                                                  style: TextStyle(
                                                    // color: expense.isBorrowed
                                                    // ? Colors.red
                                                    //     : Colors.green,
                                                    color: Colors.green,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            )
                                          else if (expense["user_share"] > 0)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '\$${expense["user_share"].toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  "you borrowed",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            )
                                          else if (state
                                                      .userDetails["user_id"] !=
                                                  expense["paid_by"]["ID"] &&
                                              expense["user_owed"] ==
                                                  expense["user_share"])
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Not Involved",
                                                  style: TextStyle(
                                                    color: Colors.cyan,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            )
                                          else
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Your own expense",
                                                  style: TextStyle(
                                                    color: Colors.cyan,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            )
                                        ],
                                      )));
                            },
                          ),
                        ),
                      ]);
                    } else if (state is GetUserDetailsFailure) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: Text("No expenses available"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
