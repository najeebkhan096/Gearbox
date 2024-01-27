import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gearbox/Screens/onboard.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) {
          return OnboardingScreen();
        }),
      );
    });
    super.initState();
  }

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
                "images/car.png",
                fit: BoxFit.fill,
                width: width * 1,
                height: height * 1,
              ),
            ),
            Positioned(
              width: width * 1,
              top: height * 0.1,
              child: Padding(
                padding: const EdgeInsets.only(top: 11.0),
                child: Center(
                  child: Image.asset(
                    "images/logo.png",
                    width: width * 0.45,
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
                  WhiteTextRegular(
                    title: tr('powered_by_origin'),
                    weight: FontWeight.w500,
                    size: width * 0.035,
                  ),
                  WhiteTextRegular(
                    title: tr('all_rights_reserved_gearbox'),
                    weight: FontWeight.w500,
                    size: width * 0.035,
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
