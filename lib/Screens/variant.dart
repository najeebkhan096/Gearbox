import 'package:flutter/material.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:easy_localization/easy_localization.dart';

class VarientScreen extends StatelessWidget {
  List<String> data = [
    tr('variant_1'),
    tr('variant_2'),
    tr('variant_3'),
    tr('variant_4'),
    tr('variant_5'),
    tr('variant_6'),
    tr('variant_7'),
    tr('variant_8'),
    tr('variant_9'),
    tr('variant_10'),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darktheme ? bgcolor : Color(0xffD5D6D8),
      appBar: AppBar(
        backgroundColor: darktheme ? bgcolor : Color(0xffD5D6D8),
        actions: [
          Container(
            margin: EdgeInsets.only(right: width * 0.025),
            child: Center(
              child: RedTextRegular(
                  title: tr('skip'),
                  weight: FontWeight.w600,
                  size: width * 0.038),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: width * 0.025),
            child: Center(
              child: RedTextRegular(
                  title: tr('cancel'),
                  weight: FontWeight.w600,
                  size: width * 0.038),
            ),
          ),
        ],
        centerTitle: true,
        title: WhiteTextRegular(
            title: tr('variant'),
            weight: FontWeight.w600,
            size: width * 0.038),
      ),
      body: ListView(
        children: [
          SizedBox(height: height * 0.025),
          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            child: BlueTextRegular(
                title: tr('which_hyundai_model'),
                weight: FontWeight.w700,
                size: width * 0.045),
          ),
          SizedBox(height: height * 0.015),
          Container(
            margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            child: TextField(
              decoration: InputDecoration(
                hintText: tr('search_model'),
                hintStyle: TextStyle(
                  fontSize: width * 0.032,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins-Regular',
                  color: Color(0xff535865),
                ),
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/search.png',
                      width: width * 0.05,
                      height: height * 0.025,
                      color: Color(0xff535865),
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
                    (index) => Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: width * 0.025, right: width * 0.025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlueBlackTextRegular(
                              title: data[index],
                              weight: FontWeight.w500,
                              size: width * 0.033),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff535865),
                            size: width * 0.035,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Container(
                      width: width * 1,
                      height: height * 0.0005,
                      color: Color(0xffD5D6D8),
                    ),
                    SizedBox(height: height * 0.015),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
