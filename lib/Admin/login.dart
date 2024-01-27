import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gearbox/Admin/dashboard.dart';
import 'package:gearbox/Auth/auth.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:gearbox/modal/database.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
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
        title: BlackTextRegular(
            title: "Login", weight: FontWeight.w700, size: width * 0.03),
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
          )),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
            width: width * 0.6,
            margin: EdgeInsets.only(left: width * 0.05),
            child: BlackTextRegular(
                title: "Username/Email", weight: FontWeight.w700, size: 20),
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
            margin: EdgeInsets.only(left: width * 0.05),
            child: BlackTextRegular(
                title: "Password", weight: FontWeight.w700, size: 20),
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
          isloading
              ? SpinKitCircle(
                  color: Colors.black,
                )
              : InkWell(
                  onTap: () async {
                    Map<dynamic, dynamic>? admin_credntial =
                        await database.fetch_admin_credential();
                    if (email == admin_credntial!['user'] &&
                        password == admin_credntial['password']) {
                      if (email != null && password != null) {
                        setState(() {
                          isloading = true;
                        });

                        AuthService _auth = AuthService();

                        try {
                          final User result = await _auth
                              .signInWithEmailAndPassword(email!, password!);
                          if (result.uid.isNotEmpty) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                DashboardScreen.routename, (route) => false);
                          }
                        } catch (error) {
                          setState(() {
                            isloading = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.toString())));
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Invalid Credential")));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: width * 0.05, right: width * 0.05),
                    width: width * 1,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: darkblue),
                    child: Center(
                        child: WhiteTextRegular(
                            title: "Login", weight: FontWeight.w700, size: 20)),
                  ),
                ),
        ],
      ),
    );
  }
}
