import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/bottom_navbar.dart';
import 'package:frontend/features/viewSettlements/core/view_settlement_bloc.dart';
import 'package:frontend/features/viewSettlements/core/view_settlement_event.dart';
import 'package:frontend/features/viewSettlements/core/view_settlement_state.dart';
import 'package:frontend/common/bottom_navbar.dart';

import 'package:frontend/common/navbar.dart';
import 'package:frontend/common/header.dart';
import 'package:frontend/repository/services/expense_service/expense_details.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';

@RoutePage()
class ViewSettlementPage extends StatefulWidget {
  const ViewSettlementPage({super.key});

  @override
  State<ViewSettlementPage> createState() => _ViewSettlementPageState();
}

class _ViewSettlementPageState extends State<ViewSettlementPage> {
  final ExpenseDetails expenseDetails = ExpenseDetails();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => ViewSettlementBloc(
            authStorage: AuthStorage(), expenseDetails: ExpenseDetails())
          ..add(GetAllSettlementsEvent()),
        child: Scaffold(
            appBar: CommonNavbar(),
            body: Padding(
              padding: EdgeInsets.all(0.0),
              child: BlocBuilder<ViewSettlementBloc, ViewSettlementState>(
                  buildWhen: (previous, current) =>
                      current is AllSettlementSuccess,
                  builder: (context, state) {
                    if (state is AllSettlementSuccess) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomHeader(
                              userName: state.userData["user_name"],
                              userEmail: state.userData["user_email"],
                            ),
                            SizedBox(height: 16.0),
                            Padding(padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child : Row(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children : [
                                  Text(
                                    'Settlements History',
                                    style: TextStyle(
                                      fontSize:
                                      20.0, // Adjust the font size as needed
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                      onPressed: ()async{
                                        await expenseDetails.RequestPermission(state.userData["user_id"].toString());
                                        print("download button");
                                      },
                                    icon: const Icon(Icons.download),
                                    label: const Text('Report'),
                                      iconAlignment : IconAlignment.end,
                                  )

                                ]

                            ),
                            ),

                            // Align(
                            //   alignment: Alignment.center,
                            //   child: Text(
                            //     'Settlements History',
                            //     style: TextStyle(
                            //       fontSize:
                            //           20.0, // Adjust the font size as needed
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 16.0),
                            if (state.allData["data"]["info"] == null)
                              Center(
                                child: Text(
                                  "No settlement records",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            else
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      state.allData["data"]["info"].length,
                                  itemBuilder: (context, index) {
                                    final member =
                                        state.allData["data"]["info"][index];
                                    int loggedInUserId =
                                        state.userData["user_id"];
                                    // print('member here is $member');

                                    bool isCred = member["cred_id"] ==
                                        state.userData["user_id"];
                                    bool isDebt = member["deb_id"] ==
                                        state.userData["user_id"];
                                    bool isSett = member["sett_id"] ==
                                        state.userData["user_id"];
                                    String settleMsg = "";
                                    String setlleByMsg = "";
                                    if (isSett) {
                                      setlleByMsg = "Settled by you";
                                    } else {
                                      setlleByMsg =
                                          "Settled by ${member["settler_name"]}";
                                    }
                                    if (member["sett_id"] == loggedInUserId) {
                                      // If the logged-in user is the settler
                                      if (isCred) {
                                        settleMsg =
                                            // "You paid ${member['debtor_name']}  \$${member['amount']}";
                                            "${member['debtor_name']} paid you \$${member['amount'].toStringAsFixed(2)}";
                                      } else if (isDebt) {
                                        settleMsg =
                                            "You paid ${member["creditor_name"]}  \$${member['amount'].toStringAsFixed(2)}";
                                        // "${member['settler_name']} paid you \$${member['amount']}";
                                      }
                                    } else {
                                      // Handle other cases if needed
                                      if (isCred) {
                                        settleMsg =
                                            "${member['settler_name']} paid you  \$${member['amount'].toStringAsFixed(2)}";
                                      } else if (isDebt) {
                                        settleMsg =
                                            "You paid ${member['creditor_name']}  \$${member['amount'].toStringAsFixed(2)}";
                                      }
                                    }

                                    return Card(
                                        margin: EdgeInsets.all(10.0),
                                        child: Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.monetization_on_sharp,
                                                  color: Colors.cyan,
                                                  size: 24.0,
                                                ),
                                                SizedBox(width: 10.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        // "Settled by ${member["settler_name"]}",
                                                        "$setlleByMsg",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.0),
                                                      Text(
                                                        "$settleMsg",
                                                        style: TextStyle(
                                                          color: isCred
                                                              ? Colors.green
                                                              : Colors.red,
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                    "${member["settled_at_date"]}"),
                                              ],
                                            )));
                                  },
                                ),
                              ),
                          ]);
                    }
                    // return Text("in else");
                    else if (state is AllSettlementFailure) {
                      return Center(
                        child: Text(
                          "No settlements yet",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No Settlements Found",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      );
                    }
                  }),

            ),
            bottomNavigationBar: BottomNavbar(),

    )
    );
  }
}
