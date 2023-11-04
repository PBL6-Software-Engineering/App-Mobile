import 'package:flutter/material.dart';
import 'package:health_care/utils/config.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.social, this.onPressed})
      : super(key: key);

  final String social;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
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
            Text(
              social.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
