import 'package:flutter/material.dart';
import 'package:health_care/components/button.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/utils/text.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                    ('Forgot Password'),
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
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Config.primaryColor,
                              decoration: const InputDecoration(
                                hintText: 'Enter Email',
                                labelText: 'Email',
                                alignLabelWithHint: true,
                                prefixIcon: Icon(Icons.email_outlined),
                                prefixIconColor: Config.primaryColor,
                              ),
                            ),
                            Config.spaceSmall,
                            Button(
                              width: double.infinity,
                              title: 'Reset Password',
                              onPressed: () {
                                Navigator.of(context).pushNamed('login');
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
