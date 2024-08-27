import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:frontend/app/app_router.dart';
import 'package:frontend/common/bottom_navbar.dart';
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


  Future<void> _showConfirmDialogBox(BuildContext context, transaction, curr_user_id) async {
    // print("hii this is dialog function");
    //
    // print("from transaction, values are : $transaction");
    final debtorId = transaction["debtor_id"];
    final creditorId = transaction["creditor_id"];

    final creditorName = transaction["expense_details"]["expense_paid_by"]["user_name"];
    final debtorName = transaction["debtor_name"];
    final amount = transaction["amount"].toStringAsFixed(2);
    final expenseName = transaction["expense_details"]["expense_name"];
    bool isUserDebtor = curr_user_id == debtorId;
    bool isUserCreditor = curr_user_id == creditorId;


    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Confirm Settlement'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.blue,
                            child:

                                  Text(
                                      isUserDebtor ? "You" : debtorName[0].toUpperCase(),
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),

                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),

                      // Arrow in between
                      Icon(Icons.arrow_forward, size: 40.0, color: Colors.grey),

                      // Circle representing the other user
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.green,
                            child: Text(
                                isUserCreditor ? "You" : creditorName[0].toUpperCase(),
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8.0),

                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  if (isUserDebtor)
                  Text(
                     "You paid $creditorName",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),

                  ),
                  if (isUserCreditor)
                    Text(
                      "$debtorName paid you",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),

                    ),
                  SizedBox(height: 16.0),

                  Text(
                      "\$ $amount",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),



                  )



                ],
              ),
            ),

            actions: <Widget>[

          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog without action
                },
              ),
              ElevatedButton(
                child: Text('Confirm'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Trigger BLoC event here after confirmation
                  // context.read<SettleupBloc>().add(MakeSettlementEvent(
                  // trans_id: 'your_transaction_id',
                  // user_id: 'your_user_id',
                  // ));
                  context.read<SettleupBloc>().add(MakeSettlementEvent(
                    trans_id: transaction['ID'].toString(),
                    user_id: curr_user_id.toString(),
                  ));
                },
              ),
            ]
          ),


            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettleupBloc(
        authStorage: AuthStorage(),
        expenseDetails: ExpenseDetails(),
      )..add(GetAllSettlementDetailsEvent(group_id: widget.groupId)),
      child :
      BlocListener<SettleupBloc, SettleupState>(
          listener: (context, state) async {
            if (state is MakeSettlementSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Transaction Settled Successfully'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                ),
              );

              // to load the page when settlement is being confirmed.
              context.read<SettleupBloc>().add(GetAllSettlementDetailsEvent(group_id: widget.groupId));
              await Future.delayed(const Duration(seconds: 1));
              if (context.mounted){
                await AutoRouter.of(context).push(
                  const ViewSettlementPageRoute(),
                );
              }

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

      child: Scaffold(
        appBar: CommonNavbar(),
        body:

        Padding(
        padding: EdgeInsets.all(0.0),

        // BlocListener<SettleupBloc, SettleupState>(
        //     listener: (context, state) async {
        //       if (state is MakeSettlementSuccess) {
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(
        //             content: Text('Transaction Settled Successfully'),
        //             backgroundColor: Colors.green,
        //             duration: Duration(seconds: 1),
        //           ),
        //         );
        //         await Future.delayed(Duration(seconds: 1));
        //         await AutoRouter.of(context).push(
        //           ViewSettlementPageRoute(),
        //         );
        //       } else if (state is MakeSettlementFailure) {
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(
        //             content: Text('${state.message}'),
        //             backgroundColor: Colors.red,
        //             duration: Duration(seconds: 2),
        //           ),
        //         );
        //       }
        //     },


            child: Column(children: [
              BlocBuilder<SettleupBloc, SettleupState>(
                builder: (context, state) {
                  if (state is GetUserDetailsSuccess) {
                    final transactions =
                        state.unsettledTransactions["transactions"];

                    // return CustomHeader(
                    //   userName: state.userDetails["user_name"],
                    //   userEmail: state.userDetails["user_email"],
                    // );
                    return Column(mainAxisSize: MainAxisSize.min, children: [
                      CustomHeader(
                        userName: state.userDetails["user_name"],
                        userEmail: state.userDetails["user_email"],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    ]);
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
              Expanded(
                child: BlocBuilder<SettleupBloc, SettleupState>(
                  builder: (context, state) {
                if (state is GetUserDetailsSuccess) {
                  final transactions = state.unsettledTransactions["transactions"];
                  // print("the value here is $transactions");

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
                        final creditorName = transaction["expense_details"]["expense_paid_by"]["user_name"];
                        final debtorName = transaction["debtor_name"];
                        final amount = transaction["amount"].toStringAsFixed(2);
                        final expenseName = transaction["expense_details"]["expense_name"];
                        final curr_user_id = state.userDetails["user_id"];

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
                                        _showConfirmDialogBox(context, transaction, curr_user_id);

                                      },
                                      child: Text("Settle"),
                                    )
                                  ],
                                ),

                                // SizedBox(height: 5.0),
                                if (state.userDetails["user_id"] ==
                                    transaction["debtor_id"])
                                  Text(
                                    'You owe $creditorName \$${amount}',
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
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),



              ),


            ]



            )


        ),
        bottomNavigationBar: BottomNavbar(),
      ),
      ),
    );
  }
}
