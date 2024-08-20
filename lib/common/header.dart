import 'package:flutter/material.dart';
import "../repository/services/auth_service/auth_storage.dart";
import '../app/app_router.dart';
import 'package:auto_route/auto_route.dart';

//custom header :
class CustomHeader extends StatelessWidget {
  final String userName; // Pass the user name as a parameter
  final String userEmail;

  CustomHeader({required this.userName, required this.userEmail});

  final AuthStorage _authStorage = AuthStorage();

  void _logout(BuildContext context) async {
    // remove all shared preferences
    await _authStorage.clearAll();
    //   delete token
    await _authStorage.deleteToken("token");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Logged out successfully"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    await AutoRouter.of(context).push(LoginPageRoute());
  }

  //for profile dialog:
  void showUserDialog(BuildContext context, String userEmail, String userName) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent, // To make the Dialog transparent
          child: Transform.translate(
            offset: Offset(50.0, -170.0),
            // Adjust these values to position the dialog

            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextButton.icon(
                  //     onPressed: (){},
                  //   icon: Icon(Icons.cancel_outlined, color: Colors.black),
                  //   label : Text(""),
                  // ),
                  Text(
                    userName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    userEmail,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // actions: [
              //   ElevatedButton(
              //     onPressed: () {
              //       Navigator.of(context).pop(); // Close the dialog
              //     },
              //     child: Text('Close'),
              //   ),
              // ],
              actions: [
                TextButton.icon(
                  icon: Icon(Icons.logout, color: Colors.black),
                  label: Text("Logout", style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    _logout(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan, // Background color
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hello $userName', // Display the user name
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Handle profile icon press
              showUserDialog(context, userEmail, userName);
            },
          ),
        ],
      ),
    );
  }
}
