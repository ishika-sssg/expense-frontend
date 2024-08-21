import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:frontend/app/app_router.dart';
import 'package:frontend/common/navbar.dart';
import 'package:frontend/common/header.dart';

import 'package:frontend/features/settleup/core/settleup_event.dart';
import 'package:frontend/features/settleup/core/settleup_bloc.dart';
import 'package:frontend/features/settleup/core/settleup_state.dart';

import 'package:frontend/repository/services/auth_service/auth_storage.dart';
import 'package:frontend/repository/services/expense_service/expense_details.dart';

@RoutePage()
class SettleupPage extends StatefulWidget {
  final String groupId; // Declare groupId as an instance variable

  final String groupName;
  final String groupDescription;
  final String groupAdminId;
  final String groupAdminName;

  const SettleupPage(
      {required this.groupId,
      required this.groupName,
      required this.groupDescription,
      required this.groupAdminId,
      required this.groupAdminName,
      Key? key})
      : super(key: key);

  @override
  State<SettleupPage> createState() => _SettleupPageState();
}

class _SettleupPageState extends State<SettleupPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettleupBloc(
        authStorage: AuthStorage(),
        expenseDetails: ExpenseDetails(),
      )..add(GetAllSettlementDetailsEvent(group_id: widget.groupId)),
      child: Scaffold(
        appBar: CommonNavbar(),
        body: BlocListener<SettleupBloc, SettleupState> (
            listener: (context, state) async{
              if (state is MakeSettlementSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Transaction Settled Successfully'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 1),
                  ),
                );
                await Future.delayed(Duration(seconds: 1));
                await AutoRouter.of(context).push(
                  // AddExpensePageRoute(
                  //   groupId: widget.groupId,
                  //   groupName: widget.groupName,
                  //   groupAdminId: widget.groupAdminId,
                  //   groupAdminName: widget.groupAdminName,
                  // ),
                    ViewSettlementPageRoute(),
                );
              } else if (state is MakeSettlementFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.message}'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              }

            },
            child: Column(children: [
              BlocBuilder<SettleupBloc, SettleupState>(
                builder: (context, state) {
                  if (state is GetUserDetailsSuccess) {

                    final transactions = state.unsettledTransactions["transactions"];

                    // return CustomHeader(
                    //   userName: state.userDetails["user_name"],
                    //   userEmail: state.userDetails["user_email"],
                    // );
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children : [
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
                                "Settle Your Balances",
                                style: TextStyle(fontSize: 20),
                              ),
                              // Text(
                              //   'Admin : ${widget.groupAdminName}',
                              //   style: TextStyle(color: Colors.cyan, fontSize: 18),
                              // ),
                            ],
                          ),
                        ),


                      ]
                    );
                  }
                  // return CustomHeader(
                  //   userName: "--",
                  //   userEmail: "--",
                  // );

                  return Text("");
                },

              //   extending builder
              // ),
              // SizedBox(height: 10),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "Settle Your Balances",
              //         style: TextStyle(fontSize: 20),
              //       ),
              //       // Text(
              //       //   'Admin : ${widget.groupAdminName}',
              //       //   style: TextStyle(color: Colors.cyan, fontSize: 18),
              //       // ),
              //     ],
              //   ),
              // ),


              ),





              Expanded(child: BlocBuilder<SettleupBloc, SettleupState>(
                  builder: (context, state) {
                if (state is GetUserDetailsSuccess) {
                  final transactions = state.unsettledTransactions["transactions"];
                  print("the value here is $transactions");

                  if (state.unsettledTransactions["transactions"] == null) {
                    return Text("No Unsettled Expenses Pending",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ));
                  }

                  return ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        final creditorName = transaction["expense_details"]
                            ["expense_paid_by"]["user_name"];
                        final debtorName = transaction["debtor_name"];
                        final amount = transaction["amount"].toStringAsFixed(2);
                        final expenseName =
                            transaction["expense_details"]["expense_name"];

                        return Card(
                          margin: EdgeInsets.all(10.0),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$expenseName',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        print("settle button");
                                        context
                                            .read<SettleupBloc>()
                                            .add(MakeSettlementEvent(
                                              trans_id:
                                                  transaction['ID'].toString(),
                                              user_id: state
                                                  .userDetails["user_id"]
                                                  .toString(),
                                            ));
                                      },
                                      child: Text("Settle"),
                                    )
                                  ],
                                ),

                                // SizedBox(height: 5.0),
                                if (state.userDetails["user_id"] ==
                                    transaction["debtor_id"])
                                  Text(
                                    'you owes $creditorName \$${amount}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.red,
                                    ),
                                  ),

                                if (state.userDetails["user_id"] ==
                                    transaction["creditor_id"])
                                  Text(
                                    '$debtorName owes you \$${amount}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.green,
                                    ),
                                  ),

                                SizedBox(height: 5.0),
                                // Text(
                                //   'Created At: ${transaction["CreatedAt"]}',
                                //   style: TextStyle(
                                //     fontSize: 14.0,
                                //     color: Colors.grey,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      });
                }
                else {
                  return Center(child: CircularProgressIndicator());
                }
              }))
            ])),
      ),
    );
  }
}
