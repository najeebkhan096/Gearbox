import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gearbox/Widgets/bottom_nab_bar.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';

class CarDetailScreen extends StatelessWidget {
  final Map? car;
  CarDetailScreen({required this.car});

  final CollectionReference storesCollection =
  FirebaseFirestore.instance.collection('Stores');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(),
      backgroundColor: darktheme ? bgcolor : Colors.white,
      appBar: AppBar(
        backgroundColor: darktheme ? bgcolor : darkblue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: WhiteTextRegular(
            title: car!['title'], weight: FontWeight.w600, size: width * 0.038),
      ),
      body: ListView(
        children: [
          BuildBanner(context),
          SizedBox(height: height * 0.025),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: darktheme
                      ? WhiteTextRegularNunita(
                      title: car!['title'],
                      weight: FontWeight.w600,
                      size: width * 0.034)
                      : BlackTextRegularNunita(
                      title: car!['title'],
                      weight: FontWeight.w600,
                      size: width * 0.034)),
              SizedBox(
                height: height * 0.005,
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
          Container(
              margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: BlueBlackTextRegular(
                  title: car!['description'],
                  weight: FontWeight.w300,
                  size: width * 0.028)),
          SizedBox(height: height * 0.02),
          Container(
              margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: darktheme
                  ? WhiteTextRegularNunita(
                  title: "\$ " + car!['price'].toString(),
                  weight: FontWeight.w600,
                  size: width * 0.034)
                  : BlackTextRegularNunita(
                  title: "\$ " + car!['price'].toString(),
                  weight: FontWeight.w600,
                  size: width * 0.034)),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  makePhoneCall(car!['phone']);
                },
                child: Container(
                  width: width * 0.25,
                  height: height * 0.056,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: darktheme
                          ? Color(0xffD4E2F2)
                          : Color(0xff1B1D2A)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/Phone_fill.png",
                        width: width * 0.05,
                        color: darktheme ? Colors.black : Colors.white,
                      ),
                      SizedBox(width: width * 0.02),
                      Text(
                        tr('call'),
                        style: TextStyle(
                            color: darktheme ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width * 0.035),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  launchWhatsAppCall(car!['whatsapp']);
                },
                child: Container(
                  width: width * 0.3,
                  height: height * 0.056,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: darktheme
                          ? Color(0xffD4E2F2)
                          : Color(0xff1B1D2A)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/whatsapp (5) 1.png",
                        width: width * 0.05,
                        color: darktheme ? Colors.black : Colors.white,
                      ),
                      SizedBox(width: width * 0.02),
                      Text(
                        tr('whatsapp'),
                        style: TextStyle(
                            color: darktheme ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width * 0.035),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void makePhoneCall(String phoneNumber) async {
    final String phoneUrl = 'tel:$phoneNumber';

    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not launch $phoneUrl';
    }
  }

  void launchWhatsAppCall(String phoneNumber) async {
    final String whatsappUrl = 'https://wa.me/$phoneNumber';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  Widget BuildBanner(context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.25,
      width: width * 1,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                car!['images'][0],
              ),
              fit: BoxFit.fill)),
    );
  }
}
