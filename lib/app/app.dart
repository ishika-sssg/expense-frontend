import 'package:flutter/material.dart';
import './app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


class MyApp extends StatelessWidget {
   MyApp({super.key});

  // MyApp({super.key}){
  //   FlutterDownloader.registerCallback(downloadCallback);
  //
  // }

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


  // static void downloadCallback(String id, int status, int progress) {
  //   final taskStatus = DownloadTaskStatus.values[status];
  //   print('Download task ($id) is in status ($taskStatus) and progress ($progress)');
  // }



}
