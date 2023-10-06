import 'package:flutter/material.dart';
import 'package:health_care/main_layout.dart';
import 'package:health_care/screens/forgot_password_page.dart';
import 'package:health_care/screens/login_page.dart';
import 'package:health_care/screens/signup_page.dart';
import 'package:health_care/screens/splash.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/screens/setting_page.dart';
import 'package:health_care/screens/category_page.dart';
import 'package:health_care/screens/article_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Heath Care',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          enabledBorder: Config.outlinedBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyText1:
              TextStyle(fontSize: 13.0), // Set the default text font size to 13
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ArticlePage(),
        'main': (context) => const MainLayout(),
        'login': (context) => const LoginPage(),
        'signup': (context) => const SignUpPage(),
        'forgotpassword': (context) => const ForgotPasswordPage(),
      },
    );
  }
}
