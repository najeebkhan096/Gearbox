import 'package:flutter/material.dart';
import 'package:gearbox/Screens/create_account.dart';
import 'package:gearbox/Screens/login.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:gearbox/Widgets/wrapper.dart';
import 'package:gearbox/modal/database.dart';
import 'package:gearbox/modal/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';

class SocialMediaLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: lightblue,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: width * 0.035),
        ),
        title: BlackTextRegular(
          title: tr('login_title'),
          weight: FontWeight.w700,
          size: width * 0.03,
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.025,),
          Container(
            width: width * 0.6,
            margin: EdgeInsets.only(left: width * 0.05),
            child: BlackTextBold(
              title: tr('welcome_back'),
              weight: FontWeight.w700,
              size: width * 0.055,
            ),
          ),
          SizedBox(height: height * 0.01,),
          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            child: BlackTextRegular(
              title: tr('login_description'),
              weight: FontWeight.w500,
              size: width * 0.032,
            ),
          ),
          SizedBox(height: height * 0.2,),
          DarkBlueButton(
            title: tr('use_email_or_username'),
            onprrss: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) {
                  return LoginScreen();
                }),
              );
            },
          ),
          SizedBox(height: height * 0.035,),
          Row(
            children: [
              Expanded(child: Container(
                height: height * .002,
                decoration: const BoxDecoration(
                    color: Color(0xffF1F5F9)
                ),
              )),
              Container(
                padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04, bottom: height * 0.01,
                    top: height * 0.01),
                decoration: BoxDecoration(
                  color: Color(0xffF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "OR",
                  style: TextStyle(
                    color: Color(0xff64748B),
                    fontFamily: 'Poppins-Regular',
                  ),
                ),
              ),
              Expanded(child: Container(
                height: height * .002,
                decoration: BoxDecoration(
                    color: Color(0xffF1F5F9)
                ),
              )),
            ],
          ),
          SizedBox(height: height * 0.035,),
          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            width: width * 1,
            height: height * 0.057,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: darkblue
            ),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: width * 0.05),
                    child: Image.asset("images/apple.png", width: width * 0.06,)),
                Container(
                    margin: EdgeInsets.only(left: width * 0.134),
                    child: WhiteTextRegular(
                      title: tr('sign_in_with_apple'),
                      weight: FontWeight.w700,
                      size: width * 0.035,
                    )),
              ],
            ),
          ),
          SizedBox(height: height * 0.025,),
          InkWell(
            onTap: () async {
              await database.signInWithGoogle().then((result) async {
                await GoogleSignIn().disconnect().then((value) async {
                  if (result != null) {
                    bool exist = await database.CheckUserExistance(result.user!.uid);

                    if (exist) {
                      Navigator.of(context).pushNamedAndRemoveUntil(Wrapper.routename, (route) => false);
                    } else {
                      MyUser desireduser = MyUser();
                      desireduser.uid = result.user!.uid;
                      desireduser.username = result.user!.displayName.toString();
                      desireduser.email = result.user!.email;
                      desireduser.imageurl = result.user!.photoURL.toString();

                      await database.adduser(
                        mySelf: desireduser,
                      ).then((value) async {
                        Navigator.of(context).pushNamedAndRemoveUntil(Wrapper.routename, (route) => false);
                      });
                    }
                  }
                });
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              width: width * 1,
              height: height * 0.057,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: Color(0xffE2E8F0)
                  )
              ),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: width * 0.05),
                      child: Image.asset("images/google.png", width: width * 0.06,)),
                  Container(
                      margin: EdgeInsets.only(left: width * 0.134),
                      child: BlackTextRegular(
                        title: tr('sign_in_with_google'),
                        weight: FontWeight.w700,
                        size: width * 0.035,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.025,),
          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            width: width * 1,
            height: height * 0.057,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Color(0xffE2E8F0)
                )
            ),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: width * 0.05),
                    child: Image.asset("images/fb.png", width: width * 0.06,)),
                Container(
                    margin: EdgeInsets.only(left: width * 0.134),
                    child: LightBlueTextRegular(
                      title: tr('sign_in_facebook'),
                      weight: FontWeight.w700,
                      size: width * 0.035,
                    )),
              ],
            ),
          ),
          SizedBox(height: height * 0.035,),
          Center(
            child: BlackTextRegular(
              title: tr('not_signed_up_yet'),
              weight: FontWeight.w500,
              size: width * 0.035,
            ),
          ),
          SizedBox(height: height * 0.005,),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) {
                  return CreateAccountScreen();
                }),
              );
            },
            child: Center(
              child: BlackTextRegular(
                title: tr('create_an_account'),
                weight: FontWeight.w700,
                size: width * 0.035,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
