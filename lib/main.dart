import 'package:flutter/material.dart';
import 'app/app.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );


  runApp(MyApp());
}

