import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:health_care/screens/get_started.dart';
import 'package:health_care/utils/config.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: Container(
        width: Config.widthSize,
        height: Config.heightSize,
        child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Config.primaryColor,
              );
            } else {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        color: Colors.white,
                        child: AnimatedSplashScreen(
                          splash: Image.asset('assets/images/Logo.png'),
                          nextScreen: const GetStarted(),
                          splashTransition: SplashTransition.fadeTransition,
                          duration: 2000,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
