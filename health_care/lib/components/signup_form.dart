import 'package:flutter/material.dart';
import 'package:health_care/components/button.dart';
import 'package:health_care/components/custom_text_field.dart';
import 'package:health_care/utils/config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key, required this.onPressed}) : super(key: key);
  final Function(
    String email,
    String password,
    String passwordConfirm,
    String fullName,
  ) onPressed;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passController = TextEditingController();
  final _passConfirmController = TextEditingController();

  bool obsecurePass = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CustomTextField(
              controller: _fullNameController,
              hintText: 'Nhập họ tên ',
              labelText: 'Họ tên',
              prefixIcon: Icons.person_outlined),
          Config.spaceSmall,
          CustomTextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Nhập email',
              labelText: 'Email',
              // isEmail: true,
              prefixIcon: Icons.email_outlined),
          Config.spaceSmall,
          CustomTextField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            labelText: 'Mật khẩu',
            hintText: 'Nhập mật khẩu ',
            prefixIcon: Icons.lock_outlined,
            isPassword: true,
          ),
          Config.spaceSmall,
          CustomTextField(
            controller: _passConfirmController,
            keyboardType: TextInputType.visiblePassword,
            labelText: 'Xác nhận mật khẩu',
            hintText: 'Nhập lại mật khẩu ',
            prefixIcon: Icons.lock_outlined,
            isPassword: true,
          ),
          Config.spaceSmall,
          Button(
            height: 50,
            width: double.infinity,
            title: 'Đăng ký',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                widget.onPressed(_emailController.text, _passController.text,
                    _passConfirmController.text, _fullNameController.text);
              }
            },
            disable: false,
          )
        ],
      ),
    );
  }
}
