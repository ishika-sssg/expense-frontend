import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:frontend/app/app_router.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';

@RoutePage()

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }
  void _checkIfLoggedIn() async {
    AuthStorage authStorage = AuthStorage();
    var data = await authStorage.retrieveData() ;
    print(data);
    if (data["user_email"] != null && data["user_name"] != null) {
      // print("user is already logged in ");
      await AutoRouter.of(context).replaceAll([const ProfilePageRoute()]);
    }
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.cyanAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),

              child:


              Column(
                children : [
                  Text(
                    'Monefy',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'your expenses',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),


                ]
              )

            ),
            SizedBox(height: 2),
            // Login Button
            ElevatedButton(
              onPressed: () async{
                AutoRouter.of(context).push(const LoginPageRoute());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Register Button
            OutlinedButton(
              onPressed: () {
                AutoRouter.of(context).push(const SignupPageRoute());
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),

              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

