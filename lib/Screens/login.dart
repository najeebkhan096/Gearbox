
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gearbox/Auth/auth.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:gearbox/Widgets/wrapper.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool isloading = false;

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
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: width * 0.035,
          ),
        ),
        title: BlackTextRegular(
          title: 'login.title'.tr(),
          weight: FontWeight.w700,
          size: width * 0.03,
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.1,
          ),
          Center(
            child: Image.asset(
              "images/logo.png",
              height: height * 0.1,
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            width: width * 0.6,
            margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
            child: BlackTextRegular(
              title: 'Welcome back!'.tr()+"\n"+"Please log in to continue!".tr(),
              weight: FontWeight.w700,
              size: width * 0.03,
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            width: width * 0.6,
            margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
            child: BlackTextRegular(
              title: 'username_email'.tr(),
              weight: FontWeight.w700,
              size: width * 0.03,
            ),
          ),

          SizedBox(
            height: height * 0.01,
          ),
          CustomTextfield(
            hint: "",
            onchange: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            width: width * 0.6,
            margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
            child: BlackTextRegular(
              title: 'Password'.tr(),
              weight: FontWeight.w700,
              size: width * 0.03,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          CustomTextfield(
            hint: "",
            onchange: (value) {
              setState(() {
                password = value;
              });
            },
          ),
          SizedBox(
            height: height * 0.01,
          ),

          SizedBox(
            height: height * 0.1,
          ),
          DarkBlueButton(
            title: 'login.login_button'.tr(),
            onprrss: () async {
              if (email != null && password != null) {
                setState(() {
                  isloading = true;
                });

                AuthService auth = AuthService();

                try {
                  final User result =
                  await auth.signInWithEmailAndPassword(email!, password!);

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Wrapper.routename, (route) => false);
                } catch (error) {
                  setState(() {
                    isloading = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error.toString())),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }
}
