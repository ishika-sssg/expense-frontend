import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/common/navbar.dart';
import 'package:frontend/repository/services/auth_service/auth_api.dart';
import 'package:frontend/features/login/login_page.dart';
import 'package:frontend/repository/services/auth_service/auth_storage.dart';


import './core/signup_bloc.dart';
import './core/signup_event.dart';
import './core/signup_state.dart';

import 'package:auto_route/auto_route.dart';
import 'package:frontend/app/app_router.dart';



@RoutePage()

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // controllers to manage input field
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for the form
  String? _usernameError;
  String? _emailError;
  String? _passwordError;

  // final AuthApi _apiClient = AuthApi();

  // function to handle registration process
  void _register(BuildContext context) async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _usernameError = null;
      _emailError = null;
      _passwordError = null;
    });
    bool isValid = true;

    if (_usernameController.text.isEmpty) {
      setState(() {
        _usernameError = 'Please enter your username';
      });
      isValid = false;
    }
    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'Please enter your email';
      });
      isValid = false;
    } else if (!_isValidEmail(_emailController.text)) {
      setState(() {
        _emailError = 'Please enter a valid email';
      });
      isValid = false;
    }
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Please enter your password';
      });
      isValid = false;
    } else if (_passwordController.text.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
      isValid = false;
    }

    if (isValid) {
      String username = _usernameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      context.read<SignupBloc>().add(
            SignupSubmitted(
              username: username,
              email: email,
              password: password,
            ),
          );
    }

    //   adding validation and registration logic here:
    print('Username : $username, email : $email, password : $password');
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
  void _validateUserName(String value) {
    if (value.isEmpty) {
      setState(() {
        _usernameError = 'User name cannot be empty';
      });
    } else {
      setState(() {
        _usernameError = null;
      });
    }
  }
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
    print(data);
    if (data["user_email"] != null && data["user_name"] != null) {
      // Navigator.pushReplacementNamed(context, '/profile');
      // print("user is already logged in ");
      await AutoRouter.of(context).replaceAll([const ProfilePageRoute()]);
    }
  }


  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SignupBloc(authApi: AuthApi()),
        child: Scaffold(
          appBar: CommonNavbar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                  children: <Widget>[
                  SizedBox(height: 16.0), // Space below the AppBar
                  Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 16.0), // Space below the heading
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      errorText: _usernameError,
                    ),
                    onChanged: _validateUserName,
                  ),
                  TextFormField(
                    controller: _emailController,
                    // The validator receives the text that the user has entered.

                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: _emailError,
                    ),
                    onChanged: _validateEmail,

                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordError,
                    ),
                    onChanged: _validatePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),

                  // bloc consumer here:
                  BlocConsumer<SignupBloc, SignupState>(
                    listener: (context, state) {
                      if (state is isSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("User registered successfully"),
                            backgroundColor: Colors.green, // Background color
                            duration: Duration(seconds: 2),
                          ),
                        );
                        // Waiting for the duration of the Snackbar, then navigate to login
                        Future.delayed(Duration(seconds: 2), () {
                          AutoRouter.of(context).push(const LoginPageRoute());
                        });
                      } else if (state is isFailure) {
                        var msg = state.errorMessage;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Registration Failed : $msg"),
                            backgroundColor: Colors.red, // Background color
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is isSubmitting) {
                        return CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: (){_register(context);},
                        child: Text('Register'),
                      );
                    },
                  ),


                //   other button for login :
                  TextButton(
                onPressed: (){
                  AutoRouter.of(context).push(const LoginPageRoute());
                },
                child: Text('Already a user? Login'),
              )
                ],
              ),
            ),
          ),
        ));
  }
}


