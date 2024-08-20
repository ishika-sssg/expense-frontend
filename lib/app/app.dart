import 'package:flutter/material.dart';
import './app_router.dart';
import 'package:auto_route/auto_route.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  /// create an instance of `AppRouter`
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Expense Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
