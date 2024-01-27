import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gearbox/Screens/create_account.dart';
import 'package:gearbox/Screens/login.dart';
import 'package:gearbox/Screens/social_login.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/provider.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Container(
        height: height * 1,
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                "images/carlight.png",
                fit: BoxFit.fill,
                width: width * 1,
                height: height * 1,
              ),
            ),
            Positioned(
              top: height * 0.11,
              width: width * 1,
              child: Center(
                child: Image.asset(
                  "images/logo.png",
                  width: width * 0.7,
                  height: height * 0.2,
                ),
              ),
            ),
            Positioned(
              top: height * 0.35,
              width: width * 1,
              child: Center(
                child: Container(
                  width: width * 0.7,
                  alignment: Alignment.center,
                  child: BlackTextRegular(
                    title: tr("Everything related to your car!"),
                    weight: FontWeight.w500,
                    size: width * 0.035,
                    center: true,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              width: width * 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DarkBlueButton(
                    title: tr("get_started"),
                    onprrss: () {
                      print("jaan");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return CreateAccountScreen();
                          },
                        ),
                      );



                    },
                  ),
                  SizedBox(height: height * 0.025),
                  WhiteButton(
                    title: tr("login"),
                    onpress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return SocialMediaLoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.045),
                  WhiteTextRegular(
                    title: tr("terms_and_privacy_policy"),
                    weight: FontWeight.w600,
                    size: width * 0.032,
                  ),
                  SizedBox(height: height * 0.003),
                  DarkTextRegular(
                    title: tr("terms_and_privacy_policy_link"),
                    weight: FontWeight.w700,
                    size: width * 0.032,
                  ),
                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


