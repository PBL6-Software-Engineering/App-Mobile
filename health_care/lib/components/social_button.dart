import 'package:flutter/material.dart';
import 'package:health_care/providers/google_sign_in.dart';
import 'package:health_care/utils/config.dart';
import 'package:provider/provider.dart';

class SocialButton extends StatelessWidget {
  final String social;
  final Function() onPressed;
  final Widget loadingWidget;

  const SocialButton({
    Key? key,
    required this.social,
    required this.onPressed,
    required this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Consumer<GoogleSignInProvider>(
      builder: (context, googleSignInProvider, _) {
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            side: const BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: SizedBox(
            width: Config.screenWidth! * .4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  'assets/images/$social.png',
                  width: 30,
                  height: 30,
                ),
                if (googleSignInProvider.isLoading)
                  loadingWidget
                else
                  Text(
                    social.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
