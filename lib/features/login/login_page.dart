import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/app/app_router.dart';
import 'package:frontend/common/navbar.dart';
import 'core/login_bloc.dart';
import 'core/login_event.dart';
import 'core/login_state.dart';
import 'package:frontend/repository/services/auth_service/auth_api.dart';
import 'package:frontend/features/profile/profile_page.dart';
import 'package:auto_route/auto_route.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
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
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: _passwordError,
                      ),
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
// Background color
                            ),
                          );
                          //   directing to profile screen
                          Future.delayed(Duration(seconds: 2), () async {
                            try {
                              // print('############## navigation route');
                              await AutoRouter.of(context)
                                  .push(const ProfilePageRoute());
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
                            // print('email, password $email, $password');

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
