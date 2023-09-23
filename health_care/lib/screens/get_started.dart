import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/screens/login_page.dart';
import 'package:health_care/screens/home_page.dart';
import 'package:health_care/screens/signup_page.dart';
import 'package:health_care/utils/config.dart';
import 'package:health_care/utils/text.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: Container(
        color: Config.lightBlueColor,
        width: Config.screenWidth,
        height: Config.screenHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      "assets/images/Mask-group.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Config.spaceMedium,
                  const Text(
                    'Book an appointment with ',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    'the right doctor.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Config.spaceMedium,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/logo.svg',
                          width: 50,
                          height: 50,
                        ),
                        Config.spaceMedium,
                        Text(
                          AppText.enText['slogan_text']!,
                          textAlign: TextAlign.justify,
                        ),
                        Config.spaceMedium,
                        Row(
                          children: [
                            Image.asset('assets/images/Ellipse-1.png'),
                            Image.asset('assets/images/Ellipse-2.png'),
                            Image.asset('assets/images/Ellipse-3.png'),
                            Config.gapSmall,
                            Text(AppText.enText['user_intro']!,
                                style: const TextStyle(
                                    color: Config.lightBlueColor, fontSize: 12))
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: const Offset(
                                          0, 3), // Changes position of shadow
                                      blurRadius:
                                          10, // Adjust the blur radius as needed
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(color: Config.blueColor),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    elevation: 0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Get Started',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Config.blueColor,
                                  elevation:
                                      10, // Adjust the elevation as needed
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('signup');
                          },
                          child: const Center(
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'Create an Account? ',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                  color: Config.lightBlueColor,
                                ),
                              ),
                            ])),
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
