import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_care/components/login_form.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/components/social_button.dart';
import 'package:health_care/providers/auth_manager.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/utils/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _login(String email, String password) async {
    var data = {
      'email': email,
      'password': password,
    };

    try {
      var res = await HttpProvider().postData(data, 'api/user/login');
      var body = json.decode(res.body);

      if (res.statusCode == 200) {
        // if (body.containsKey('data')) {
        var responseData = body['data'];

        // Access user properties like this
        // var id = responseData['id'];
        // var email = responseData['email'];
        // var name = responseData['name'];
        var token = responseData['access_token'];

        // Use the user data as needed
        // print('User ID: $id');
        // print('Email: $email');
        // print('Name: $name');
        print('Token: $token');
        AuthManager.setToken(token);

        MessageDialog.showSuccess(context, body['message']);
        Navigator.of(context).pushNamed('main');
        // } else {
        //   MessageDialog.showError(
        //       context, 'Response data does not contain "data".');
        // }
      } else {
        MessageDialog.showError(context, body['message']);
      }
    } catch (error) {
      MessageDialog.showError(context, "Đã xảy ra lỗi khi đăng nhập.");
    }
  }

  // Future<UserCredential?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final UserCredential authResult =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     final User? user = authResult.user;
  //     return user;
  //   } catch (e) {
  //     print("Error signing in with Google: $e");
  //     return null;
  //   }
  // }

  // Future<UserCredential?> signInWithFacebook() async {
  //   final result = await FacebookAuth.instance.login();
  //   if (result.status == LoginStatus.success) {
  //     final AuthCredential credential =
  //         FacebookAuthProvider.credential(result.accessToken!.token);
  //     final UserCredential authResult =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     final User? user = authResult.user;
  //     return user;
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: Config.screenWidth,
          height: Config.screenHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(AppText.enText['welcome_text']!,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      )),
                  Center(
                    child: Image.asset(
                      'assets/images/login3.jpg',
                      width: 250,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(AppText.enText['logIn_text']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Config.spaceSmall,
                  LoginForm(onPressed: _login),
                  Config.spaceSmall,
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('forgotpassword');
                      },
                      child: Center(
                        child: Text(
                          AppText.enText['forgot_password']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      )),
                  Config.spaceSmall,
                  Center(
                    child: Text(
                      AppText.enText['social_text']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Config.spaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // SocialButton(
                      //   social: 'google',
                      //   onPressed: () async {
                      //     User? user = await signInWithGoogle();
                      //     if (user != null) {
                      //       // User is logged in with Google
                      //     } else {
                      //       // Handle login failure
                      //     }
                      //   },
                      // ),
                      // SocialButton(
                      //   social: 'facebook',
                      //   onPressed: () async {
                      //     User? user = await signInWithFacebook();
                      //     if (user != null) {
                      //       // User is logged in with Facebook
                      //     } else {
                      //       // Handle login failure
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                  Config.spaceSmall,
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('signup');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppText.enText['signUp_text']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Text(
                          'Đăng ký ngay',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Config.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
