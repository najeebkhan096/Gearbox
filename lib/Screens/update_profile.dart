import 'package:flutter/material.dart';
import 'package:gearbox/Screens/login.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:easy_localization/easy_localization.dart';

class UpdateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darktheme ? bgcolor : const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: darktheme ? bgcolor : darkblue,
        centerTitle: true,
        title: WhiteTextRegular(
          title: tr('update_profile'),
          weight: FontWeight.w700,
          size: width * 0.035,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.045),
            Container(
              width: width * 0.6,
              margin: EdgeInsets.only(left: width * 0.05),
              child: darktheme
                  ? WhiteTextRegular(
                  title: tr('name'),
                  weight: FontWeight.w700,
                  size: width * 0.03)
                  : BlackTextRegular(
                  title: tr('name'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(height: height * 0.007),
            LightCustomTextfield(hint: tr('ahmed_hussain_mujtaba')),
            SizedBox(height: height * 0.025),
            Container(
              width: width * 0.6,
              margin: EdgeInsets.only(left: width * 0.05),
              child: darktheme
                  ? WhiteTextRegular(
                  title: tr('email'),
                  weight: FontWeight.w700,
                  size: width * 0.03)
                  : BlackTextRegular(
                  title: tr('email'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(height: height * 0.007),
            LightCustomTextfield(hint: tr('ahmed@gmail.com')),
            SizedBox(height: height * 0.025),
            Container(
              width: width * 0.6,
              margin: EdgeInsets.only(left: width * 0.05),
              child: darktheme
                  ? WhiteTextRegular(
                  title: tr('mobile'),
                  weight: FontWeight.w700,
                  size: width * 0.03)
                  : BlackTextRegular(
                  title: tr('mobile'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(height: height * 0.007),
            LightCustomTextfield(hint: tr('9223456789')),
            SizedBox(height: height * 0.025),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
              margin: EdgeInsets.only(
                left: width * 0.2,
                right: width * 0.2,
              ),
              child: darktheme
                  ? LightBlueButton(
                title: tr('update_profile'),
                onprrss: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return LoginScreen();
                    }),
                  );
                },
              )
                  : DarkBlueButton(
                title: tr('update_profile'),
                onprrss: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return LoginScreen();
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
