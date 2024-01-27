import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gearbox/Auth/auth.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:gearbox/Widgets/wrapper.dart';
import 'package:gearbox/modal/database.dart';
import 'package:gearbox/modal/user.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  MyUser desireduser = MyUser();
  String? passowrd;
  AuthService _auth = AuthService();

  int CarIndex = 0;
  bool isload = false;
  String? confirmpassword;

  bool CheckValidity() {
    // Regular expression for validating an Email
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    if (desireduser.username == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('fill_username_field'))));
      return false;
    } else if (desireduser.email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('fill_email_field'))));
      return false;
    } else if (passowrd == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('fill_password_field'))));
      return false;
    } else if (confirmpassword == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('fill_confirm_password_field'))));
      return false;
    } else if (desireduser.CarBrand == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('select_car_brand'))));
      return false;
    } else if (desireduser.carModal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('select_car_modal'))));
      return false;
    } else if (passowrd != confirmpassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('password_not_match'))));
      return false;
    }

    // Check if the email matches the regular expression
    else if (!emailRegex.hasMatch(desireduser.email!)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr('invalid_email'))));
      return false;
    } else {
      return true;
    }
  }

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
            child: Icon(Icons.arrow_back_ios_new,
                color: Colors.black, size: width * 0.035)),
        title: BlackTextRegular(
            title: tr('create_account'),
            weight: FontWeight.w700,
            size: width * 0.03),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.025),
            Center(child: Image.asset("images/logo.png", height: height * 0.085)),
            SizedBox(height: height * 0.025),
            Center(
              child: Container(
                width: width * 0.7,
                margin: EdgeInsets.only(left: width * 0.05),
                child: BlackTextRegular(
                    title: tr('signup_description'),
                    weight: FontWeight.w700,
                    size: width * 0.033),
              ),
            ),
            SizedBox(height: height * 0.025),
            Container(
              width: width * 0.6,
              margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
              child: BlackTextRegular(
                  title: tr('name'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(height: height * 0.007),
            CustomTextfield(
              hint: "",
              onchange: (val) {
                setState(() {
                  desireduser.username = val;
                });
              },
            ),
            SizedBox(height: height * 0.01),
            Container(
              width: width * 0.6,
              margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
              child: BlackTextRegular(
                  title: tr('email'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(height: height * 0.01),
            CustomTextfield(
              hint: "",
              onchange: (val) {
                setState(() {
                  desireduser.email = val;
                });
              },
            ),
            SizedBox(height: height * 0.01),
            Container(
              width: width * 0.6,
              margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
              child: BlackTextRegular(
                  title: tr('password'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(height: height * 0.01),
            CustomTextfield(
              hint: "",
              onchange: (val) {
                setState(() {
                  passowrd = val;
                });
              },
            ),
            SizedBox(height: height * 0.01),
            Container(
              width: width * 0.6,
              margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
              child: BlackTextRegular(
                  title: tr('confirm_password'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(height: height * 0.01),
            CustomTextfield(
              hint: "",
              onchange: (val) {
                setState(() {
                  confirmpassword = val;
                });
              },
            ),
            SizedBox(height: height * 0.01),
            Container(
              width: width * 0.6,
              margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
              child: BlackTextRegular(
                  title: tr('select_car_brand'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(height: height * 0.01),
            CustomDropdown(
                hint: "",
                dropdownItems: groupedCarModels,
                onChanged: (value) {
                  CarIndex = database.findManufacturerIndex(value!);
                  print("index is " + CarIndex.toString());
                  setState(() {
                    desireduser.CarBrand = value;
                  });
                }),
            if (desireduser.CarBrand != null)
              Container(
                width: width * 0.6,
                margin: EdgeInsets.only(left: width * 0.05, top: height * 0.025,right: width*0.05),
                child: BlackTextRegular(
                    title: tr('select_car_modal'),
                    weight: FontWeight.w700,
                    size: width * 0.03),
              ),
            if (desireduser.CarBrand != null)
              SizedBox(height: height * 0.01),
            if (desireduser.CarBrand != null)
              CustomDropdownString(
                  hint: "",
                  dropdownItems: groupedCarModels[CarIndex]["Models"],
                  onChanged: (value) {
                    desireduser.carModal = value;
                  }),
            SizedBox(height: height * 0.025),
            isload
                ? Center(child: SpinKitCircle(color: Colors.black))
                : DarkBlueButton(
              title: tr('continue'),
              onprrss: () async {
                setState(() {
                  isload = true;
                });
                var validity = CheckValidity();

                if (validity) {
                  try {
                    final User user =
                    await _auth.registerWithEmailAndPassword(
                        email: desireduser.email,
                        password: passowrd);
                    desireduser.uid = user.uid;

                    if (desireduser.uid!.isNotEmpty) {
                      await database
                          .adduser(mySelf: desireduser)
                          .then((value) async {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Wrapper.routename, (route) => false);
                      });
                    }
                  } catch (error) {
                    setState(() {
                      isload = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                  }
                } else {
                  setState(() {
                    isload = false;
                  });
                }
              },
            ),
            SizedBox(height: height * 0.025),
            Container(
              margin: EdgeInsets.only(
                left: width * 0.05,
                right: width * .05,
              ),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: tr('terms_and_conditions'),
                      style: TextStyle(
                          color: const Color(0xff555555),
                          fontSize: width * 0.031,
                          fontFamily: 'Poppins-Regular'),
                    ),
                    TextSpan(
                      text: ' ',
                      style: TextStyle(
                          color: const Color(0xff191919),
                          fontSize: width * 0.031,
                          fontFamily: 'Poppins-Regular'),
                    ),
                    TextSpan(
                      text: tr('and_agree_to'),
                      style: TextStyle(
                          color: const Color(0xff555555),
                          fontSize: width * 0.031,
                          fontFamily: 'Poppins-Regular'),
                    ),
                    TextSpan(
                      text: ' ',
                      style: TextStyle(
                          color: const Color(0xff191919),
                          fontSize: width * 0.031,
                          fontFamily: 'Poppins-Regular'),
                    ),
                    TextSpan(
                      text: tr('privacy_policy'),
                      style: TextStyle(
                        color: const Color(0xff191919),
                        fontSize: width * 0.031,
                        fontFamily: 'Poppins-Regular',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.025),
          ],
        ),
      ),
    );
  }
}
