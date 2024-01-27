import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:gearbox/Widgets/wrapper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map> _pages = [
    {
      "title": "onboarding.select_brand",
      "description": "onboarding.brand_description",
      "imagePath": "images/onbaord.png",
    },
    {
      "title": "onboarding.find_store",
      "description": "onboarding.store_description",
      "imagePath": "images/onboard2.png",
    },
    {
      "title": "onboarding.enjoy_service",
      "description": "onboarding.service_description",
      "imagePath": "images/onboard3.png",
    },
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f7),
      body: PageView.builder(
        controller: pageController,
        onPageChanged: _onPageChanged,
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return OnboardingPage(
            title: tr(_pages[index]['title']),
            description: tr(_pages[index]['description']),
            imagePath: _pages[index]['imagePath'],
          );
        },
      ),
    );
  }

  Widget OnboardingPage({
    required String title,
    required String description,
    required String imagePath,
  }) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Image.asset(
          imagePath,
          height: height * 0.5,
          width: width * 1,
          fit: BoxFit.fill,
        ),
        Positioned(
          bottom: height * 0.2,
          width: width * 1,
          child: Container(
            margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
            width: width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.only(
              left: width * 0.1,
              bottom: height * 0.035,
              right: width * 0.1,
            ),
            child: Column(
              children: [
                SizedBox(height: height * 0.05),
                DarkBlackTextRegular(
                  title: title,
                  weight: FontWeight.w700,
                  size: width * 0.05,
                  center: true,
                ),
                SizedBox(height: height * 0.025),
                GreyTextRegular(
                  title: description,
                  weight: FontWeight.w600,
                  size: width * 0.03,
                  center: true,
                ),
                SizedBox(height: height * 0.05),
                RoundDarkBlueButton(
                  title: "onboarding.next",
                  onpress: () {
                    if (_currentPage < _pages.length - 1) {
                      pageController.animateToPage(
                        _currentPage + 1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(Wrapper.routename, (route) => false);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: height * 0.1,
          width: width * 1,
          child: Center(
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: WormEffect(
                dotWidth: 9.0,
                dotHeight: 9.0,
                paintStyle: PaintingStyle.stroke,
                dotColor: Color(0xff666666),
                activeDotColor: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
