import 'package:client_mobile/app.dart';
import 'package:client_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var token = preferences.getString('token');

  //
  runApp(MaterialApp(
    builder: (context, widget) => ResponsiveWrapper.builder(
      BouncingScrollWrapper.builder(context, widget!),
      maxWidth: 1200,
      minWidth: 400.0,
      defaultScale: true,
      breakpoints: const [
        ResponsiveBreakpoint.resize(450, name: MOBILE),
        ResponsiveBreakpoint.resize(800, name: TABLET),
        ResponsiveBreakpoint.resize(1000, name: TABLET),
        ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        ResponsiveBreakpoint.resize(2460, name: '4K'),
      ],
    ),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.blue),
    home: token == null ? const LoginPage() : const AppPage(),
  ));
}
