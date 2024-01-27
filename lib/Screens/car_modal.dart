import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gearbox/Screens/service2.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';

class CarModalScreen extends StatelessWidget {
  List<String> data = [
    "Accent",
    "Active",
    "i20",
    "Aura",
    "Creta",
    "Elantra",
    "Elite i20",
    "Eon",
    "Fluidic Elantra",
    "Fluidic Verma",
    "Getz",
    "Getz Prime",
    "Grandeur",
    "i10",
    "i20"
  ];

  CarModalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: darktheme ? bgcolor : Colors.white,
      appBar: AppBar(
        backgroundColor: bgcolor,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: width * 0.025),
            child: Center(
              child: RedTextRegular(
                title: tr('cancel'),
                weight: FontWeight.w600,
                size: width * 0.038,
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: WhiteTextRegular(
          title: tr('car_modal'),
          weight: FontWeight.w600,
          size: width * 0.038,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: height * 0.025),
          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            child: BlueTextRegular(
              title: tr('which_hyundai_model'),
              weight: FontWeight.w700,
              size: width * 0.045,
            ),
          ),
          SizedBox(height: height * 0.015),
          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            child: TextField(
              decoration: InputDecoration(
                hintText: tr('search_modal'),
                hintStyle: TextStyle(
                  fontSize: width * 0.032,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins-Regular',
                  color: const Color(0xff535865),
                ),
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/search.png',
                      width: width * 0.05,
                      height: height * 0.025,
                      color: const Color(0xff535865),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.025),
          SizedBox(height: height * 0.01),
          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            child: Column(
              children: List.generate(
                data.length,
                    (index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return ServiceScreen2();
                      }),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width * 0.025, right: width * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlueBlackTextRegular(
                              title: data[index],
                              weight: FontWeight.w500,
                              size: width * 0.033,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: const Color(0xff535865),
                              size: width * 0.035,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      Container(
                        width: width * 1,
                        height: height * 0.0005,
                        color: const Color(0xffD5D6D8),
                      ),
                      SizedBox(height: height * 0.015),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
