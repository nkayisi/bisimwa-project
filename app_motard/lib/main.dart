import 'package:app_motard/pages/home_page.dart';
import 'package:app_motard/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var token = preferences.getString('token');

  //
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? const LoginPage() : const HomePage(),
    ),
  );
}
