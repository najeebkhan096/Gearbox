import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gearbox/Widgets/bottom_nab_bar.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:geocoding/geocoding.dart';

import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
class WorkshopsDetailScreen extends StatelessWidget {
  static const routename="WorkshopsDetailScreen";

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
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


  List<Map> data=[
    {
      'title':'Toyota',
      'image':'icons/toyota-removebg-preview.png'
    },
    {
      'title':'Vagon',
      'image':'icons/vagon-removebg-preview.png'
    },
    {
      'title':'Porche',
      'image':'icons/porche-removebg-preview.png'
    },
    {
      'title':'',
      'image':'icons/pic1-removebg-preview.png'
    },
    {
      'title':'Nissan',
      'image':'icons/nissan-removebg-preview.png'
    },
    {
      'title':'',
      'image':'icons/lion-removebg-preview.png'
    },
    {
      'title':'Land rover',
      'image':'icons/landrover-removebg-preview.png'
    },
    {
      'title':'ISUZU',
      'image':'icons/isuzu-removebg-preview.png'
    },
    {
      'title':'Hyundai',
      'image':'icons/hyundai-removebg-preview.png'
    },
    {
      'title':'GMC',
      'image':'icons/gmc-removebg-preview.png'
    },
    {
      'title':'FORD',
      'image':'icons/ford-removebg-preview.png'
    },
    {
      'title':'BMW',
      'image':'icons/bmw-removebg-preview.png'
    },

  ];

  String ? distanceString(double ? distance){

    String text='';
    if(distance!>=1000){
      distance=distance/1000;

      text=distance.toStringAsFixed(2)+" Km";

    }
    else{
      text=distance.toStringAsFixed(2)+"m";
    }
    return text;
  }

  double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
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
        cos(toRadians(startLatitude)) * cos(toRadians(endLatitude)) * haversin(deltaLongitude);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Distance in meters
  }
  Future<double> getDistance(String address)async{
    double distance=0;
    Location  ?loc     =await  convertAddressToCoordinates(address);

    Position Currentposition = await _determinePosition();
    distance=calculateDistance(Currentposition.latitude, Currentposition.longitude,
        loc.latitude, loc.longitude);




    return distance;
  }
  Map<dynamic,dynamic> ? workshop;

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;

    workshop=ModalRoute.of(context)!.settings.arguments as  Map<String, dynamic>;

    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(),
      backgroundColor: darktheme?bgcolor:Colors.white,
      appBar: AppBar(
        backgroundColor:darktheme?bgcolor:darkblue,



        centerTitle: true,
        title: WhiteTextRegular(title: workshop!['title'], weight: FontWeight.w600, size: width*0.038),
      ),

      body: ListView(

        children: [
          BuildBanner(context),
          SizedBox(height: height*0.025,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  child:

                  darktheme?
                  WhiteTextRegularNunita(title: workshop!['title'], weight: FontWeight.w600, size: width*0.034):
                  BlackTextRegularNunita(title: workshop!['title'], weight: FontWeight.w600, size: width*0.034)),

              SizedBox(height: height*0.005,),
              Container(
                  width: width*0.5,
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                  child:
                  darktheme?   WhiteTextRegularNunita(title: workshop!['location'], weight: FontWeight.w300, size: width*0.03):
                  BlackTextRegularNunita(title: workshop!['location'], weight: FontWeight.w300, size: width*0.03)),

            ],
          ),
          SizedBox(height: height*0.005,),
        darktheme?   Container(
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            child: WhiteTextRegularNunita(title:"Description", weight: FontWeight.w600, size: width*0.035)):
        Container(
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            child: BlackTextRegularNunita(title: "Description", weight: FontWeight.w600, size: width*0.035)),

          SizedBox(height: height*0.005,),
          Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              child: BlueBlackTextRegular (title: workshop!['description'], weight: FontWeight.w300, size: width*0.028)),

          SizedBox(height: height*0.02,),

          FutureBuilder(future:
          getDistance(workshop!['location']),

              builder: (ctx,snaps){
                return snaps.connectionState==ConnectionState.waiting?
                WhiteTextRegular(title: "0 KM away", weight: FontWeight.w500, size: width*0.025):
                snaps.hasData?
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:
                        darktheme?
                            Colors.grey
                            :
                        Color(0xff2E3192),
                        )
                    ),
                    child: Text( distanceString(snaps.data).toString()+" away",
                      style: TextStyle(
                          color:

                          darktheme?
                              Colors.grey
                              :
                          Color(0xff2E3192),
                          fontSize: width*0.025
                      ),
                    ),
                  ),
                )

                    : WhiteTextRegular(title: "0 KM away", weight: FontWeight.w500, size: width*0.025);
              }),

          SizedBox(height: height*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                   makePhoneCall(workshop!['phone']);

                },
                child: Container(

                  width: width*0.25,
                  height: height*0.056,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      color:
                      darktheme?
                      Color(0xffD4E2F2):
                      Color(0xff1B1D2A)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/Phone_fill.png",
                        width: width*0.05,
                        color: darktheme?Colors.black:Colors.white,

                      ),
                      SizedBox(width: width*0.02,),
                      Text("Call".tr(),
                        style: TextStyle(
                            color: darktheme?Colors.black:Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width*0.035
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  launchWhatsAppCall(workshop!['whatsapp']);
                },
                child: Container(

                  width: width*0.3,
                  height: height*0.056,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      color:darktheme?
                      Color(0xffD4E2F2): Color(0xff1B1D2A)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/whatsapp (5) 1.png",
                        width: width*0.05,
                        color: darktheme?Colors.black:Colors.white,
                      ),
                      SizedBox(width: width*0.02,),
                      Text("Whatsapp".tr(),
                        style: TextStyle(
                            color: darktheme?Colors.black:Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width*0.035
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {

                  Location  ? loc=await  convertAddressToCoordinates(workshop!['location']);

                  Position position = await _determinePosition();
                  LatLng ?  endingPoint = LatLng(lat:loc.latitude,lng: loc.longitude);
                  LatLng ?startingPoint =  LatLng(lat: position.latitude, lng: position.longitude);

                  String origin = 'origin=${startingPoint.lat},${startingPoint.lng}';
                  String destination = 'destination=${endingPoint.lat},${endingPoint.lng}';
                  String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1&$origin&$destination';


                  if (await canLaunch(googleMapsUrl)) {
                    await launch(googleMapsUrl,

                    );
                  } else {
                    // Could not open the map.
                    print('Could not launch Google Maps');
                  }
                },
                child: Container(

                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      color:
                      darktheme?
                      Color(0xffD4E2F2):
                      Color(0xff1B1D2A)
                  ),
                  child: Row(
                    children: [

                      Image.asset("images/location.png",
                          width: width*0.035,
                          color:
                          darktheme?
                          Color(0xff1B1D2A)
                              :
                          Colors.white
                      ),

                      SizedBox(width: width*0.02,),

                      Text("Location".tr(),
                        style: TextStyle(
                            color: darktheme?Colors.black:Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width*0.035
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height*0.02,),

          Container(
              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
              child:
              darktheme?
              WhiteTextRegularNunita(title: "We are specialised in".tr(), weight: FontWeight.w600, size: width*0.034)
                  :
              BlackTextRegularNunita(title: "We are specialised in".tr(), weight: FontWeight.w600, size: width*0.034)),

          SizedBox(height: height*0.02,),
          Container(
            height: height*0.47,
            margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: height*0.12
                // Number of items in each row
              ),
              itemCount: data.length,
              physics: NeverScrollableScrollPhysics(),

              // Number of items you want to display
              itemBuilder: (BuildContext context, int index) {
                // Generate your items here
                return Container(

                  width: width*0.25,
                  margin: EdgeInsets.only(right: width*0.05,
                      bottom: height*0.02
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffC2CCD8),
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: height*0.025,),

                      Container(
                        margin: EdgeInsets.only(left: 2,right: 2),
                        child: Image.asset(data[index]['image'],fit: BoxFit.fill,height: height*0.05,),
                      ),


                    ],
                  ),
                );
              },

            ),
          ),
          SizedBox(height: height*0.025,),

          SizedBox(height: height*0.025,),

        ],
      ),
    );
  }
  Widget BuildBanner(context){
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  Container(
      height: height*0.25,
      width: width*1,
      decoration: BoxDecoration(
          image: DecorationImage(image:
          NetworkImage(workshop!['image'],
          ),
              fit: BoxFit.fill
          )
      ),



    );
  }
}
