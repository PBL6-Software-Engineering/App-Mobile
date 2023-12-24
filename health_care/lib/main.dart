import 'package:flutter/material.dart';
import 'package:health_care/main_layout.dart';
import 'package:health_care/providers/auth_intercetor.dart';
import 'package:health_care/providers/auth_manager.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/screens/booking_history_page.dart';
import 'package:health_care/screens/booking_search.dart';
import 'package:health_care/screens/forgot_password_page.dart';
import 'package:health_care/screens/login_page.dart';
import 'package:health_care/screens/search_page.dart';
import 'package:health_care/screens/signup_page.dart';
import 'package:health_care/screens/splash.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/screens/setting_page.dart';
import 'package:health_care/screens/category_page.dart';
import 'package:health_care/screens/article_page.dart';
import 'package:health_care/objects/articles.dart';
import 'package:health_care/screens/appointment_page.dart';
import 'package:health_care/screens/message_page.dart';
import 'package:health_care/screens/home_page.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthManager.init();

  final interceptors = <InterceptorContract>[];
  interceptors.add(AuthInterceptor());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // const MyApp({super.key});
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
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.lightBlueAccent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 13.0),
        ),
      ),
      initialRoute: '/',
      routes: {
        //'/': (context) => const AppointmentPage(),
        // '/': (context) => const Welcome(),
        //  '/': (context) => const HomePage(),
        //'/': (context) => const LoginPage(),
        '/': (context) => const MainLayout(initialPageIndex: 0),
        'main': (context) => const MainLayout(initialPageIndex: 0),
        'login': (context) => const LoginPage(),
        'signup': (context) => const SignUpPage(),
        'forgotpassword': (context) => const ForgotPasswordPage(),
        'setting': (context) => const MainLayout(initialPageIndex: 3),
        'search': (context) => SearchPage(),
        'booking-search': (context) => BookingSearchPage(),

        //'article': (context)=>ArticlePage(),
      },
    );
  }
}
