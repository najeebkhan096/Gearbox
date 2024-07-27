import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gearbox/Screens/login.dart';
import 'package:gearbox/Screens/update_profile.dart';
import 'package:gearbox/Widgets/bottom_nab_bar.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:gearbox/Widgets/wrapper.dart';
import 'package:gearbox/modal/database.dart';
import 'package:gearbox/modal/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map> cars = [
    {
      'title': 'PEUGEOT 2019',
      'engine': '308',
      'image': 'images/car11.png'
    },
    {
      'title': 'MERCEDES BENZ',
      'engine': 'C 300',
      'image': 'images/car22.png'
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    currentIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(),
      backgroundColor: darktheme ? bgcolor : const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: darktheme ? bgcolor : Color(0xff0D1B2B),
        centerTitle: true,
        title: WhiteTextRegular(
          title: tr('profile.title'),
          weight: FontWeight.w700,
          size: width * 0.035,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.045,
            ),
            Center(
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg"),
              ),
            ),
            SizedBox(
              height: height * 0.035,
            ),
            Container(
              width: width * 0.6,
              margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
              child: darktheme
                  ? WhiteTextRegular(
                  title: tr('profile.name'),
                  weight: FontWeight.w700,
                  size: width * 0.03)
                  : BlackTextRegular(
                  title: tr('profile.name'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(
              height: height * 0.007,
            ),
            if (currentUser != null)
              LightCustomTextfield(
                hint: currentUser!.username.toString(),
                underlineBorder: true,
              ),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
              width: width * 0.6,
              margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
              child: darktheme
                  ? WhiteTextRegular(
                  title: tr('profile.email'),
                  weight: FontWeight.w700,
                  size: width * 0.03)
                  : BlackTextRegular(
                  title: tr('profile.email'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(
              height: height * 0.007,
            ),
            LightCustomTextfield(
              hint: currentUser!.email.toString(),
              underlineBorder: true,
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
              child: darktheme
                  ? WhiteTextRegular(
                  title: tr('profile.mobile'),
                  weight: FontWeight.w700,
                  size: width * 0.03)
                  : BlackTextRegular(
                  title: tr('profile.mobile'),
                  weight: FontWeight.w700,
                  size: width * 0.03),
            ),
            SizedBox(
              height: height * 0.007,
            ),
            LightCustomTextfield(
              hint: "9223456789",
              underlineBorder: true,
            ),
            SizedBox(
              height: height * 0.025,
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
              margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
              child: BlueTextRegularNunita(
                  title: tr('profile.my_cars'),
                  weight: FontWeight.w700,
                  size: width * 0.035),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Card(
                color: darktheme ? bgcolor : Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: darktheme
                          ? const Color(0xff3D3D3D)
                          : Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(
                  left: width * 0.065,
                  right: width * 0.065,
                  bottom: height * 0.02,
                ),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.033,
                      right: width * 0.025,
                      top: height * 0.025,
                      bottom: height * 0.025),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          darktheme
                              ? WhiteTextRegularNunita(
                              title: currentUser!.CarBrand.toString(),
                              weight: FontWeight.w500,
                              size: width * 0.032)
                              : BlackTextRegularNunita(
                              title: currentUser!.CarBrand.toString(),
                              weight: FontWeight.w500,
                              size: width * 0.032),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          darktheme
                              ? WhiteTextBold(
                              title: tr('profile.engine'),
                              weight: FontWeight.w700,
                              size: width * 0.032)
                              : WhiteTextBold(
                              title: tr('profile.engine'),
                              weight: FontWeight.w700,
                              size: width * 0.032),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: width * 0.025, right: width * 0.025),
                        child: Image.asset(
                          cars[0]['image'],
                          width: width * 0.35,
                        ),
                      ),
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
              margin: EdgeInsets.only(
                left: width * 0.2,
                right: width * 0.2,
              ),
              child: darktheme == false
                  ? DarkBlueButton(
                title: tr('profile.save'),
                onprrss: () {

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return LoginScreen();
                      }));
                },
              )
                  : LightBlueButton(
                title: tr('profile.save'),
                onprrss: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return LoginScreen();
                      }));
                },
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
                margin: EdgeInsets.only(left: width * 0.05,right: width*0.05),
                child: BlueTextRegularNunita(
                    title: tr('profile.notifications'),
                    weight: FontWeight.w700,
                    size: width * 0.035)),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
              decoration: BoxDecoration(
                  color: darktheme
                      ? const Color(0xff181818)
                      : const Color(0xffF1F4F7)),
              padding: EdgeInsets.only(
                  left: width * 0.05,
                  right: width * 0.05,
                  bottom: height * 0.015,
                  top: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  darktheme
                      ? WhiteTextRegularNunita(
                      title: tr('profile.notification_toggle'),
                      weight: FontWeight.w600,
                      size: width * 0.035)
                      : BlackTextRegularNunita(
                      title: tr('profile.notification_toggle'),
                      weight: FontWeight.w600,
                      size: width * 0.035),
                  Switch(
                    value: true,
                    onChanged: (val) {},
                    activeColor: darktheme ? Colors.white : bgcolor,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
              decoration: BoxDecoration(
                  color: darktheme
                      ? const Color(0xff181818)
                      : const Color(0xffF1F4F7)),
              padding: EdgeInsets.only(
                  left: width * 0.05,
                  right: width * 0.05,
                  bottom: height * 0.015,
                  top: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  darktheme
                      ? WhiteTextRegularNunita(
                      title: tr('profile.dark_mode'),
                      weight: FontWeight.w600,
                      size: width * 0.035)
                      : BlackTextRegularNunita(
                      title: tr('profile.dark_mode'),
                      weight: FontWeight.w600,
                      size: width * 0.035),
                  Switch(
                    value: darktheme,
                    onChanged: (val) {
                      setState(() {
                        darktheme = val;
                      });
                    },
                    activeColor: darktheme ? Colors.white : bgcolor,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
              decoration: BoxDecoration(
                  color: darktheme
                      ? const Color(0xff181818)
                      : const Color(0xffF1F4F7)),
              padding: EdgeInsets.only(
                  left: width * 0.05,
                  right: width * 0.05,
                  bottom: height * 0.015,
                  top: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  darktheme
                      ? WhiteTextRegularNunita(
                      title: tr('profile.language'),
                      weight: FontWeight.w600,
                      size: width * 0.035)
                      : BlackTextRegularNunita(
                      title: tr('profile.language'),
                      weight: FontWeight.w600,
                      size: width * 0.035),

                  DropdownButton(
                    underline: Text(""),
                    value: context.locale,

                    items: [
                      DropdownMenuItem(
                        child:   BlackTextRegularNunita(
                            title: tr('English'),
                            weight: FontWeight.w600,
                            size: width * 0.035),
                        value: Locale('en', 'US'),
                      ),
                      DropdownMenuItem(
                        child:    BlackTextRegularNunita(
                            title: tr('Arabic'),
                            weight: FontWeight.w600,
                            size: width * 0.035),
                        value: Locale('ar', 'DZ'),
                      ),
                    ],
                    onChanged: (Locale? value) {

                      if (value != null) {
                      if(value.countryCode =="DZ"){
                        context.setLocale(Locale('ar', 'DZ'));
                      }
                      else{
                             context.setLocale(Locale('en', 'US'));

                      }

                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                  left: width * 0.2,
                  right: width * 0.2,
                ),
                child: darktheme == false
                    ? DarkBlueButton(
                  title: tr('profile.edit'),
                  onprrss: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) {
                          return UpdateProfileScreen();
                        }));
                  },
                )
                    : LightBlueButton(
                  title: tr('profile.edit'),
                  onprrss: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) {
                          return UpdateProfileScreen();
                        }));
                  },
                )),
            SizedBox(
              height: height * 0.025,
            ),
            Container(
                margin: EdgeInsets.only(
                  left: width * 0.2,
                  right: width * 0.2,
                ),
                child: darktheme == false
                    ? DarkBlueButton(
                  title: tr('profile.logout'),
                  onprrss: () async {
                    // Do something when a menu item is selected
                    try {
                      final googleSignIn = GoogleSignIn();
                      await googleSignIn.signOut().then((value) async {
                        FirebaseAuth _auth =
                        await FirebaseAuth.instance;
                        _auth.signOut().then((value) {
                          currentUser = null;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Wrapper.routename, (route) => false);
                        });
                      });
                    } catch (error) {
                      FirebaseAuth _auth =
                      await FirebaseAuth.instance;
                      _auth.signOut().then((value) {
                        currentUser = null;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Wrapper.routename, (route) => false);
                      });
                    }
                  },
                )
                    : LightBlueButton(
                  title: tr('profile.logout'),
                  onprrss: () async {
                    // Do something when a menu item is selected
                    try {
                      final googleSignIn = GoogleSignIn();
                      await googleSignIn.signOut().then((value) async {
                        FirebaseAuth _auth =
                        await FirebaseAuth.instance;
                        _auth.signOut().then((value) {
                          currentUser = null;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Wrapper.routename, (route) => false);
                        });
                      });
                    } catch (error) {
                      FirebaseAuth _auth =
                      await FirebaseAuth.instance;
                      _auth.signOut().then((value) {
                        currentUser = null;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Wrapper.routename, (route) => false);
                      });
                    }
                  },
                )),
            SizedBox(
              height: height * 0.075,
            ),
          ],
        ),
      ),
    );
  }
}
