import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/app/app_router.dart';
import 'package:frontend/common/navbar.dart';
import 'core/login_bloc.dart';
import 'core/login_event.dart';
import 'core/login_state.dart';
import 'package:frontend/repository/services/auth_service/auth_api.dart';
import 'package:auto_route/auto_route.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';


@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _emailError;
  String? _passwordError;



  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailError = 'Email cannot be empty';
      });
    } else {
      setState(() {
        _emailError = null;
      });
    }
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordError = 'Password cannot be empty';
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }
  void _checkIfLoggedIn() async {
    AuthStorage authStorage = AuthStorage();
    // Call retrieveData from authstorage.dart to get the value
    var data = await authStorage.retrieveData() ;

    if (data["isLoggedIn"] == true) {
      // Navigator.pushReplacementNamed(context, '/profile');
      print("user is already logged in ");
    }
  }
  @override
  void dispose() {
    // _emailFocusNode.dispose();
    // _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonNavbar(),

      body: BlocProvider(
        create: (context) => LoginBloc(authApi: AuthApi()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 16.0),

              // making a form
              Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: _emailError,
                      ),
                      onChanged: _validateEmail,

                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: _passwordError,
                      ),
                      onChanged: _validatePassword,
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is isSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Logged in successfully"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          //   directing to profile screen
                          Future.delayed(Duration(seconds: 2), () async {
                            try {
                              // print('############## navigation route');
                              await AutoRouter.of(context)
                                  .replaceAll([const ProfilePageRoute()]);
                            } catch (err) {
                              // print("************************Error navigating to ProfilePageRoute: $err");
                              print(err);
                              return err;
                            }
                          });
                        } else if (state is isFailure) {
                          //
                          var msg = state.errorMessage;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed login: $msg"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is isSubmitting) {
                          return CircularProgressIndicator();
                        }

                        return ElevatedButton(
                          onPressed: () {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            setState(() {
                              _emailError = _emailController.text.isEmpty
                                  ? 'Email cannot be empty'
                                  : null;
                              _passwordError = _passwordController.text.isEmpty
                                  ? 'Password cannot be empty'
                                  : null;
                            });
                            // print('email, password , $password');

                            //adding validation
                            if (email.isNotEmpty && password.isNotEmpty) {
                              context.read<LoginBloc>().add(
                                    LoginSubmitted(
                                      email: email,
                                      password: password,
                                    ),
                                  );
                            }
                          },
                          child: Text('Login'),
                        );
                      },
                    ),
                  ])),

              //   other button for register screen :
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).push(const SignupPageRoute());
                },
                child: Text("Don't have an account ? Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
