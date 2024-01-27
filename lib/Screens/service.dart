import 'package:flutter/material.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:easy_localization/easy_localization.dart';

class ServiceScreen extends StatefulWidget {
  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  List<Map> data = [
    {'title': 'Spare Parts', 'image': 'Bodyparts/parts5.png', 'status': false},
    {'title': 'Service & Oil', 'image': 'Bodyparts/parts4.png', 'status': false},
    {'title': 'Tune / accessories', 'image': 'Bodyparts/parts3.png', 'status': false},
    {'title': 'Emergency', 'image': 'Bodyparts/parts1.png', 'status': false},
    {'title': 'Buying car', 'image': 'Bodyparts/parts2.png', 'status': false},
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darktheme ? bgcolor : const Color(0xffD5D6D8),
      appBar: AppBar(
        backgroundColor: darktheme ? bgcolor : const Color(0xffD5D6D8),
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.white,),
        centerTitle: true,
        title: Image.asset('images/logo2.png', width: width * 0.3),
      ),
      body: Container(
        height: height * 1,
        margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05, top: height * 0.035),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              crossAxisSpacing: width * 0.1,
              mainAxisExtent: height * 0.18
          ),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  data[index]['status'] = !data[index]['status'];
                });
              },
              child: Container(
                height: height * 0.05,
                width: width * 0.1,
                margin: EdgeInsets.only(
                  bottom: height * 0.02,
                ),
                decoration: BoxDecoration(
                  color: data[index]['status'] ? const Color(0xffD5D7E4) : Colors.transparent,
                  border: Border.all(
                    color: const Color(0xffC2CCD8),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.025,),
                    Container(
                      margin: const EdgeInsets.only(left: 2, right: 2),
                      child: Image.asset(data[index]['image'], fit: BoxFit.fill, height: height * 0.085),
                    ),
                    SizedBox(height: height * 0.005,),
                    Text(
                      tr('service.${data[index]['title']}'),
                      style: TextStyle(
                        fontSize: width * 0.034,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins-Bold',
                        color: const Color(0xff535865),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
