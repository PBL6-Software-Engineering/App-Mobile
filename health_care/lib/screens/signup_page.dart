import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_care/components/SignUp_form.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/components/social_button.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/screens/login_page.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/utils/text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  _signup(String email, String password, String passwordConfirm,
      String fullName) async {
    var data = {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirm,
      'name': fullName
    };

    try {
      var res = await HttpProvider().postData(data, 'api/infor-user/register');
      var body = json.decode(res.body);

      if (body['success'] = true) {
        MessageDialog.showSuccess(context, body['message']);
        Navigator.of(context).pushNamed('login');
      } else {
        if (body.containsKey('errors') && body['errors'] is List<String>) {
          MessageDialog.showError(context, body['errors'][0]);
        } else if (body.containsKey('message')) {
          MessageDialog.showError(context, body['message']);
        } else {
          MessageDialog.showError(context, "An error occurred.");
        }
      }
    } catch (error) {
      MessageDialog.showError(context, "An error occurred: $error");
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/images/signup1.jpg',
                      width: 250,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text('Đăng ký',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                  Config.spaceSmall,
                  SignUpForm(onPressed: _signup),
                  Config.spaceSmall,
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('login');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Bạn đã có tài khoản? ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const Text(
                          'Đăng nhập',
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
