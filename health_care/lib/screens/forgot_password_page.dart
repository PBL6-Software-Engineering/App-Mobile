import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/components/button.dart';
import 'package:health_care/components/custom_text_field.dart';
import 'package:health_care/components/message_dialog.dart';
import 'package:health_care/providers/http_provider.dart';
import 'package:health_care/utils/config.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _forgotPassword(String email) async {
    var data = {
      'email': email,
    };

    try {
      var res =
          await HttpProvider().postData(data, 'api/user/forgot-pw-sendcode');
      var body = json.decode(res.body);

      if (body['success'] = true) {
        MessageDialog.showSuccess(context, body['message']);
        Navigator.of(context).pushNamed('login');
      } else {
        MessageDialog.showError(context, body['message']);
      }
    } catch (error) {
      MessageDialog.showError(context, "Đã xảy ra lỗi khi đặt lại mật khẩu.");
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
                  Center(
                    child: Image.asset(
                      'assets/images/forgot.jpg',
                      width: 450,
                      height: 450,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    ('Quên mật khẩu'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Config.spaceSmall,
                  Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CustomTextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Nhập email',
                                labelText: 'Email',
                                isEmail: true,
                                prefixIcon: Icons.email_outlined),
                            Config.spaceSmall,
                            Button(
                              height: 50,
                              width: double.infinity,
                              title: 'Lấy lại mật khẩu',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _forgotPassword(_emailController.text);
                                }
                              },
                              disable: false,
                            )
                          ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
