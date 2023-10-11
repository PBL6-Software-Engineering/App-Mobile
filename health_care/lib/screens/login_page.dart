import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/components/login_form.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/components/social_button.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/screens/signup_page.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/utils/text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
      var res = await HttpProvider().postData(data, '/user/login');
      var body = json.decode(res.body);

      if (res.statusCode == 200) {
        MessageDialog.showSuccess(context, body['message']);
        Navigator.of(context).pushNamed('main');
      } else {
        MessageDialog.showError(context, body['message']);
      }
    } catch (error) {
      MessageDialog.showError(context, "Đã xảy ra lỗi khi đăng nhập.");
    }
  }

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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SocialButton(social: 'google'),
                      SocialButton(social: 'facebook'),
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
                        const Text(
                          'Đăng ký ngay',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Config.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
