import 'dart:async';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gearbox/Screens/home.dart';
import 'package:gearbox/Screens/mycars.dart';
import 'package:gearbox/Widgets/bottom_nab_bar.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:gearbox/Widgets/wrapper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class ServiceScreen2 extends StatefulWidget {
  @override
  State<ServiceScreen2> createState() => _ServiceScreen2State();
}

class _ServiceScreen2State extends State<ServiceScreen2> {
  List<Map> data = [
    {
      'title': 'Service',
      'image': 'images/service/service-removebg-preview.png',
      'subdata': [
        {'title': "Oil", 'status': false},
        {'title': "Wash", 'status': false},
        {'title': "Tires", 'status': false},
      ],
      'status': false
    },
    {
      'title': 'Spare Parts',
      'image': 'images/service/spare-removebg-preview.png',
      'status': false
    },
    {
      'title': 'Tune / accessories',
      'image': 'images/service/tuneac-removebg-preview.png',
      'status': false
    },
    {
      'title': 'Buy car',
      'image': 'images/service/buycar-removebg-preview.png',
      'status': false
    },
  ];
  double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    const double earthRadius = 6371000; // Earth radius in meters

    double toRadians(double degrees) {
      return degrees * (pi / 180);
    }

    num haversin(double theta) {
      return pow(sin(theta / 2), 2);
    }

    double deltaLatitude = toRadians(endLatitude - startLatitude);
    double deltaLongitude = toRadians(endLongitude - startLongitude);

    double a = haversin(deltaLatitude) +
        cos(toRadians(startLatitude)) *
            cos(toRadians(endLatitude)) *
            haversin(deltaLongitude);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Distance in meters
  }

  Future<double> getDistance(String address) async {
    double distance = 0;
    Location? loc = await convertAddressToCoordinates(address);

    Position Currentposition = await _determineCurrentPosition();
    distance = calculateDistance(Currentposition.latitude,
        Currentposition.longitude, loc.latitude, loc.longitude);

    return distance;
  }

  Future<Position> _determineCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<Location> convertAddressToCoordinates(String address) async {
    try {
      final List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        final Location location = locations.first;

        return location;
      } else {
        throw Exception('No coordinates found for the given address.');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  late StreamController<bool> _locationPermissionController;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    _locationPermissionController = StreamController<bool>();
  }

  @override
  void dispose() {
    _locationPermissionController.close();
    super.dispose();
  }

  Future<Position> _determinePosition() async {
    // Your implementation to get the current position
    // This could involve using the geolocator package or another location service
    Position result = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return result;
  }

  Future<void> checkAndRequestLocationPermission(BuildContext context) async {
    try{
      var status = await Permission.location.status;

      if (status == PermissionStatus.granted) {
        // Location permission already granted
        _locationPermissionController.add(true);
      } else if (status == PermissionStatus.permanentlyDenied) {
        // Location permission permanently denied
        _locationPermissionController.add(false);
      } else {
        // Location permission not granted, request permission
        var result = await Permission.location.request();
        _locationPermissionController.add(result == PermissionStatus.granted);
      }

    }catch(error){
      Navigator.of(context).pushNamedAndRemoveUntil(Wrapper.routename, (route) => false);
    }

  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    try{
      await checkAndRequestLocationPermission(context).then((value) {});
      super.didChangeDependencies();
    }
    catch(error){

    }

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      stream: _locationPermissionController.stream,
      initialData: null, // Set initial data based on your app's logic
      builder: (ctx, AsyncSnapshot<bool> permissionSnapshot) {
        bool? isLocationPermissionGranted;
        if (permissionSnapshot.hasData) {
          // Handle the result of the location permission request
          isLocationPermissionGranted = permissionSnapshot.data!;
        }
        if (permissionSnapshot.connectionState == ConnectionState.waiting &&
            !permissionSnapshot.hasData) {
          return const SpinKitCircle(color: Colors.white);
        } else if (permissionSnapshot.data == null) {
          return const SpinKitCircle(color: Colors.white);
        } else if (isLocationPermissionGranted!) {
          // Location permission granted, navigate to ServiceScreen2
          return Scaffold(
            bottomNavigationBar: MyBottomNavBar(),
            backgroundColor:
                darktheme ? const Color(0xff1c1c1c) : const Color(0xffD5D6D8),
            appBar: AppBar(
              // actions: [
              //   Padding(
              //     padding: EdgeInsets.only(right: width * 0.035),
              //     child: const Icon(
              //       Icons.search,
              //       color: Colors.white,
              //     ),
              //   )
              // ],
              backgroundColor: darktheme ? bgcolor : darkblue,
              elevation: 0,
            //   leading: const Icon(
            //     Icons.menu,
            //     color: Colors.white,
            //   ),
            //   centerTitle: true,
             ),
            body: ListView(
              children: [
                SizedBox(
                  height: height * 0.025,
                ),
                darktheme == false
                    ? Center(
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/logo.png"),
                                  fit: BoxFit.fill)),
                        ),
                      )
                    : Center(
                        child: Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          height: height * 0.078,
                          width: width * 0.3,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/whitelogo.png"),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                SizedBox(
                  height: height * 0.025,
                ),
                Column(
                  children: List.generate(
                      data.length,
                      (index) => Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    data[index]['status'] =
                                        !data[index]['status'];
                                  });
                                  if (index == 3) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return MyCarsScreen();
                                    })).then((value) {
                                      setState(() {
                                        currentIndex = 0;
                                      });
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: width * 1,
                                  margin: EdgeInsets.only(
                                    bottom: height * 0.02,
                                    left: width * 0.05,
                                    right: width * 0.05,
                                  ),
                                  decoration: BoxDecoration(
                                      color: darktheme
                                          ? const Color(0xff0D0D0D)
                                          : Colors.white,
                                      border: Border.all(
                                        color: darktheme
                                            ? Colors.grey
                                            : data[index]['status']
                                                ? blue
                                                : const Color(0xffC2CCD8),
                                      ),
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        data[index]['image'],
                                        fit: BoxFit.fill,
                                        height: height * 0.04,
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(right: width * 0.1),
                                        child: Text(
                                          data[index]['title'].toString().tr(),
                                          style: TextStyle(
                                            fontSize: width * 0.034,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Nunito-Regular',
                                            color: darktheme
                                                ? Colors.grey
                                                : const Color(0xff535865),
                                          ),
                                        ),
                                      ),
                                      index == 0
                                          ? data[index]['status']
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: height * 0.001),
                                                  child: Icon(
                                                    Icons
                                                        .keyboard_arrow_up_sharp,
                                                    color: darktheme
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: height * 0.0015),
                                                  child: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: darktheme
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                )
                                          : const Text("")
                                    ],
                                  ),
                                ),
                              ),
                              if (index == 0 && data[index]['status'] == true)
                                Container(
                                  width: width * 1,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                          (data[index]['subdata'] as List)
                                              .length,
                                          (subdata_index) => InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    data[index]['subdata']
                                                                [subdata_index]
                                                            ['status'] =
                                                        !data[index]['subdata']
                                                                [subdata_index]
                                                            ['status'];
                                                  });
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  margin: EdgeInsets.only(
                                                    bottom: height * 0.02,
                                                    left: width * 0.05,
                                                  ),
                                                  width: width * 0.23,
                                                  decoration: BoxDecoration(
                                                      color: darktheme
                                                          ? Color(0xff0D0D0D)
                                                          : Colors.white,
                                                      border: Border.all(
                                                        color: darktheme
                                                            ? blue
                                                            : data[index]['subdata']
                                                                        [
                                                                        subdata_index]
                                                                    ['status']
                                                                ? blue
                                                                : const Color(
                                                                    0xffC2CCD8),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40)),
                                                  child: Center(
                                                    child: Text(
                                                      data[index]['subdata']
                                                              [subdata_index]
                                                          ['title'].toString().tr(),
                                                      style: TextStyle(
                                                        fontSize: width * 0.034,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            'Nunito-Regular',
                                                        color: darktheme
                                                            ? blue
                                                            : Color(0xff535865),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ))),
                                ),
                            ],
                          )),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                InkWell(
                  onTap: () async {
                    List<String> selected_items = [];

                    data.forEach((element) {
                      if (element['status'] == true &&
                          element['title'] != "Buy car") {
                        if (element['title'] == "Service") {
                          (element['subdata'] as List<dynamic>)
                              .forEach((subelement) {
                            if (subelement['status'] == true) {
                              selected_items.add(subelement['title']);
                            }
                          });
                        } else {
                          selected_items.add(element['title']);
                        }
                      }
                    });
                    if (currentLocation == null) {
                      var status = await Permission.location.status;
                      if (status == PermissionStatus.granted) {
                        // Location permission already granted
                        _locationPermissionController.add(true);
                        Position result = await _determinePosition();
                        currentLocation =
                            LatLng(result.latitude, result.longitude);
                        Navigator.of(context).pushNamed(HomeScreen.routename,
                            arguments: ['partial', selected_items]);
                      }
                      ;
                    } else {
                      Navigator.of(context).pushNamed(HomeScreen.routename,
                          arguments: ['partial', selected_items]);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: width * 1,
                    margin: EdgeInsets.only(
                      bottom: height * 0.02,
                      left: width * 0.05,
                      right: width * 0.05,
                    ),
                    decoration: BoxDecoration(
                        color: const Color(0xff1c1c1c),
                        border: Border.all(
                          color: const Color(0xffC2CCD8),
                        ),
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text(
                        "Continue".tr(),
                        style: TextStyle(
                          fontSize: width * 0.034,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito-Regular',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.5,
                  child: BlackTextRegular(
                    title: "Press the button below help will reach you soon.".tr(),
                    weight: FontWeight.w400,
                    size: width * 0.03,
                    center: true,
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                GestureDetector(
                  onTap: () async {
                    if (currentLocation == null) {
                      var status = await Permission.location.status;
                      if (status == PermissionStatus.granted) {
                        // Location permission already granted
                        _locationPermissionController.add(true);
                        Position result = await _determinePosition();
                        currentLocation =
                            LatLng(result.latitude, result.longitude);
                        Navigator.of(context).pushNamed(HomeScreen.routename,
                            arguments: ['all']);
                      }
                    } else {
                      Navigator.of(context)
                          .pushNamed(HomeScreen.routename, arguments: ['all']);
                    }
                  },
                  child: Image.asset(
                    "images/emergency.png",
                    height: height * 0.18,
                  ),
                )
              ],
            ),
          );
        } else {
          // Location permission denied
          return LocationDeniedScreen(
            onRetry: () async {
              // Retry button pressed, navigate back to check and request location permission
              await checkAndRequestLocationPermission(context);
              setState(() {});
            },
          );
          // or return another widget or handle denial as needed
        }
      },
    );
  }
}
