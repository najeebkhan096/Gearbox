import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gearbox/Screens/Workshops.dart';
import 'package:gearbox/Screens/mycars.dart';
import 'package:gearbox/Screens/profile.dart';
import 'package:gearbox/Screens/service2.dart';
import 'package:gearbox/Widgets/constant.dart';

class MyBottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BottomNavigationBar(
      backgroundColor: darktheme ? bgcolor : Colors.white,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Color(0xff707477),
      selectedItemColor: Color(0xffCD212A),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            "images/nav/home_alt_fill.png",
            width: width * 0.05,
            color: currentIndex == 0
                ? Color(0xffCD212A)
                : Color(0xff707477),
          ),
          label: 'Home'.tr(), // Use translations
        ),
        // BottomNavigationBarItem(
        //   icon: Image.asset(
        //     "images/nav/cars.png",
        //     width: width * 0.05,
        //     color: currentIndex == 1
        //         ? Color(0xffCD212A)
        //         : Color(0xff707477),
        //   ),
        //   label: 'Cars'.tr(), // Use translations
        // ),
        // BottomNavigationBarItem(
        //   icon: Image.asset(
        //     "images/nav/shop.png",
        //     width: width * 0.05,
        //     color: currentIndex == 2
        //         ? Color(0xffCD212A)
        //         : Color(0xff707477),
        //   ),
        //   label: 'Shops'.tr(), // Use translations
        // ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "images/nav/profile.png",
            width: width * 0.05,
            color: currentIndex == 1
                ? Color(0xffCD212A)
                : Color(0xff707477),
          ),
          label: 'Profile'.tr(), // Use translations
        ),
      ],
      onTap: (index) {
        int temp = currentIndex;
        setState(() {
          currentIndex = index;
        });
        if (index == 0) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) {
              return ServiceScreen2();
            }),
          );
        }
        // if (index == 1) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(builder: (ctx) {
        //       return MyCarsScreen();
        //     }),
        //   );
        // }
        // if (index == 2) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(builder: (ctx) {
        //       return WorkshopsScreen();
        //     }),
        //   );
        // }

        if (index == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) {
              return ProfileScreen();
            }),
          );
        }
      },
    );
  }
}
