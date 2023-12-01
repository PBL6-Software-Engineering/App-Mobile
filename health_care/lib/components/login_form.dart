import 'package:flutter/material.dart';
import 'package:health_care/components/button.dart';
import 'package:health_care/components/custom_text_field.dart';
import 'package:health_care/utils/config.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, required this.onPressed}) : super(key: key);
  final Function(String email, String password) onPressed;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CustomTextField(
              key: Key('emailField'),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Nhập email',
              labelText: 'Email',
              prefixIcon: Icons.email_outlined),
          Config.spaceSmall,
          CustomTextField(
            key: Key('passwordField'),
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            labelText: 'Mật khẩu',
            hintText: 'Nhập mật khẩu ',
            prefixIcon: Icons.lock_outlined,
            isPassword: true,
          ),
          Config.spaceSmall,
          Button(
            key: Key('loginButton'),
            height: 50,
            width: double.infinity,
            title: 'Đăng nhập',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                widget.onPressed(_emailController.text, _passController.text);
              }
            },
            disable: false,
          )
        ],
      ),
    );
  }
}
