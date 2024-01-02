import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_care/components/login_form.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/components/social_button.dart';
import 'package:health_care/providers/auth_manager.dart';
import 'package:health_care/providers/google_sign_in.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/utils/text.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ChangeNotifier {
  late bool isLoading = false;

  _login(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    var data = {
      'email': email,
      'password': password,
    };

    try {
      var res = await HttpProvider().postData(data, 'api/user/login');
      var body = json.decode(res.body);

      if (res.statusCode == 200) {
        var responseData = body['data'];
        var token = responseData['access_token'];

        AuthManager.setToken(token);
        AuthManager.setUser(await AuthManager.fetchUser());

        MessageDialog.showSuccess(context, body['message']);
        Navigator.of(context).pushNamed('main');
      } else {
        MessageDialog.showError(context, body['message']);
      }
    } catch (error) {
      MessageDialog.showError(context, "Đã xảy ra lỗi khi đăng nhập.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          // width: Config.screenWidth,
          // height: Config.screenHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
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
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(AppText.enText['logIn_text']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Config.spaceSmall,
                  LoginForm(onPressed: _login, isLoading: isLoading),
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
                      SocialButton(
                        social: 'google',
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin(context);
                        },
                        loadingWidget: CircularProgressIndicator(),
                      ),
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
