import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gearbox/Screens/pinLocation.dart';

import 'package:gearbox/Screens/workshopDetails.dart';
import 'package:gearbox/Widgets/bottom_nab_bar.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  static const routename="HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {





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

  Future<String> getCurrentLocationAddress() async {
    try {
      List<Placemark> marks = await placemarkFromCoordinates(
        currentLocation!.latitude,
        currentLocation!.longitude,
      );
      Placemark placemark = marks.first;

      // Build the address string using the available placemark properties
      String address = '${placemark.name ?? ''}, ${placemark.locality ?? ''}, ${placemark.country ?? ''}';

      // You can customize the format based on your requirements

      return address;
    } catch (e) {

      return 'Error getting address';
    }
  }
String ? selectedCar;
@override
  void initState() {
    // TODO: implement initState
  currentIndex=0;
  super.initState();
  }
  final CollectionReference storesCollection =
  FirebaseFirestore.instance.collection('Stores');

  Future<String?> getCityFromAddress(String fullAddress) async {
    try {
      List<Location> locations = await locationFromAddress(fullAddress);

      if (locations.isNotEmpty) {
        List<Placemark> placemarks =
        await placemarkFromCoordinates(locations.first.latitude, locations.first.longitude);

        if (placemarks.isNotEmpty) {
          String city = placemarks.first.locality ?? '';
          return city;
        }
      }
      return null; // Unable to retrieve location or city from the provided address
    } catch (e) {
      print('Error getting city from address: $e');
      return null; // Handle errors
    }
  }
List<String> selected_items=[];
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
 final getdata =ModalRoute.of(context)!.settings.arguments as List;
 if(getdata[0]!='all'){
  selected_items=getdata[1] ;

 }

    return Scaffold(
      backgroundColor: darktheme?bgcolor:Colors.white,
      bottomNavigationBar: MyBottomNavBar(),
      appBar: AppBar(
        backgroundColor:darktheme?bgcolor:darkblue,
        elevation: 0,
        // leading: Icon(Icons.menu,color: Colors.white,),
        // actions: [
        //   Padding(
        //     padding:  EdgeInsets.only(right: width*0.035),
        //     child: Icon(Icons.search,color: Colors.white,),
        //   )
        // ],
      centerTitle: true,
      title: WhiteTextRegular(title: 'Dashboard'.tr(), weight: FontWeight.w600, size: width*0.038),
      ),
      body: ListView(

        children: [
          BuildBanner(context),
   SizedBox(height: height*0.025,),
          InkWell(
            onTap: ()async{

              Navigator.of(context).push(
               MaterialPageRoute(
                   builder: (ctx){
                 return PinLocationScreen();
               })
              ).then((value) {
                setState(() {

                });
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                children: [

                Icon(Icons.add_location,color: darktheme?Colors.white:Colors.black,size: 15,),
        currentLocation==null?
                Container(
                    margin: EdgeInsets.only(left: width*0.01),
                    child: BlackTextRegular(title: 'Current location', weight: FontWeight.w500, size: width*0.038)):
        FutureBuilder<String>(
          future: getCurrentLocationAddress(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  width: width*0.3,
                  child: LinearProgressIndicator()); // Or any other loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              String address = snapshot.data ?? 'Unknown Address';
              return Container(
                width: width*0.8,
                child: BlackTextRegular(
                  title: address,
                  weight: FontWeight.w500,
                  size: width * 0.038,
                ),
              );
            }
          },
        ),


              ],),
            ),
          ),
          SizedBox(height: height*0.025,),
   Container(
       margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
       child: BlackTextBold(title: 'Which car do you drive?'.tr(), weight: FontWeight.w700, size: width*0.038)),

          SizedBox(height: height*0.01,),
   LightBorderCustomDropdown(hint: "Select Manufacture".tr(), dropdownItems: groupedCarModels, onChanged: (val){
   setState(() {
     selectedCar=val;
   });


   }),


          SizedBox(height: height*0.015,),
        getdata[0]=='all'?
        FutureBuilder<QuerySnapshot>(
          future: storesCollection.get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 300,
                width: 100,
                child: Center(
                  child: SpinKitCircle(
                    color: Colors.black,
                  ),
                ),
              );
            }
          List<DocumentSnapshot> documents =[];
            if(selectedCar==null){
  documents=snapshot.data!.docs;
            }
            else
            // If there are no errors and the data is ready, display it
     documents = snapshot.data!.docs.where((element) =>
            (element['brands'] as List).contains(selectedCar)).toList();


            return

              documents.isEmpty?
                  Container(
                      height: height*0.3,
                      width: width*0.5,
                      child: const Center(child: Text("No Store Available")))
                  :
              Container(
              height: height*1,
              margin: EdgeInsets.only(left: width*0.04,right: width*0.04),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: height*0.35,
                    crossAxisSpacing: width*.025
                  // Number of items in each row
                ),
                physics: NeverScrollableScrollPhysics(),
                itemCount: documents.length,

                // Number of items you want to display
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;


                  // Generate your items here
                  return

                    InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(WorkshopsDetailScreen.routename,
                          arguments: data
                      );
                    },
                    child: Container(
                      height: height*0.07,

                      margin: EdgeInsets.only(
                          bottom: height*0.02
                      ),
                      decoration: BoxDecoration(

                          color:

                          darktheme?
                          Color(0xffD4E2F2)
                              :
                          Color(0xff0e1b2b),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(

                        children: [

                          Container(
                            height: height*0.19,
                            width: width*1,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(
                                    data['image']
                                ),
                                    fit: BoxFit.fill
                                ),

                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),

                          SizedBox(height: height*0.01,),

                          darktheme?
                          BlackTextRegular(title: data['title'], weight: FontWeight.w700, size: width*0.032)

                              :
                          WhiteTextRegular(title: data['title'], weight: FontWeight.w700, size: width*0.032),


                          SizedBox(height: height*0.005,),

                          darktheme?
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 4),
                            child: BlackTextRegular(title: data['location'], weight: FontWeight.w500, size: width*0.025),
                          )
                              :
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 4),
                            child: WhiteTextRegular(title: data['location'], weight: FontWeight.w500, size: width*0.025),
                          ),

                        ],
                      ),
                    ),
                  );
                },

              ),
            );

          },
        ):

          FutureBuilder<QuerySnapshot>(
            future: storesCollection.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 300,
                  width: 100,
                  child: Center(
                    child: SpinKitCircle(
                      color: Colors.black,
                    ),
                  ),
                );
              }

              // If there are no errors and the data is ready, display it
              final List<DocumentSnapshot> documents = snapshot.data!.docs;



 return Wrap(
   children: List.generate(documents.length, (index) {
     Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
     return
     selected_items.contains(data['type'])?
     InkWell(
       onTap: (){
         Navigator.of(context).pushNamed(WorkshopsDetailScreen.routename,
             arguments: data
         );
       },
       child: Container(

        width: width*0.35,
         margin: EdgeInsets.only(
             bottom: height*0.02,
           left: width*0.05
         ),
         padding: EdgeInsets.only(bottom: 10),
         decoration: BoxDecoration(

             color:

             darktheme?
             Color(0xffD4E2F2)
                 :
             Color(0xff0e1b2b),
             borderRadius: BorderRadius.circular(20)
         ),
         child: Column(

           children: [

             Container(
               height: height*0.19,
               width: width*1,
               decoration: BoxDecoration(
                   image: DecorationImage(image: NetworkImage(
                       data['image']
                   ),
                       fit: BoxFit.fill
                   ),

                   borderRadius: BorderRadius.circular(20)
               ),
             ),

             SizedBox(height: height*0.01,),

             darktheme?
             BlackTextRegular(title: data['title'], weight: FontWeight.w700, size: width*0.032)

                 :
             WhiteTextRegular(title: data['title'], weight: FontWeight.w700, size: width*0.032),


             SizedBox(height: height*0.005,),


             darktheme?
             Padding(
               padding: const EdgeInsets.only(left: 8.0, right: 4),
               child: FutureBuilder<String?>(
                 future: getCityFromAddress(data['location']),
                 builder: (context, snapshot) {
                   if (snapshot.connectionState == ConnectionState.waiting) {
                     return Container(
                         width: 40,
                         margin: EdgeInsets.only(top: 5),
                         child: LinearProgressIndicator());
                   } else if (snapshot.hasError) {
                     return Text('Error: ${snapshot.error}');
                   } else {
                     String city = snapshot.data ?? 'Unknown City';
                     return BlackTextRegular(
                       title: city,
                       weight: FontWeight.w500,
                       size: MediaQuery.of(context).size.width * 0.025,
                     );
                   }
                 },
               ),
             )
                 :
             Padding(
               padding: const EdgeInsets.only(left: 8.0, right: 4),
               child: FutureBuilder<String?>(
                 future: getCityFromAddress(data['location']),
                 builder: (context, snapshot) {
                   if (snapshot.connectionState == ConnectionState.waiting) {
                     return Container(
                         width: 40,
                         margin: EdgeInsets.only(top: 5),
                         child: LinearProgressIndicator()); // Or any other loading indicator
                   } else if (snapshot.hasError) {
                     return Text('Error: ${snapshot.error}');
                   } else {
                     String city = snapshot.data ?? 'Unknown City';
                     return WhiteTextRegular(
                       title: city,
                       weight: FontWeight.w500,
                       size: MediaQuery.of(context).size.width * 0.025,
                     );
                   }
                 },
               ),
             )


           ],
         ),
       ),
     ):Text("");
   }),
 )   ;

            },
          ),

          SizedBox(height: height*0.025,),

        ],
      ),
    );
  }

  Widget BuildBanner(context){
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  Container(
      height: height*0.22,
      width: width*1,
      decoration: BoxDecoration(
          image: DecorationImage(image:
          AssetImage("images/pic2.png",
          ),
              fit: BoxFit.cover
          )
      ),

      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: width*0.075,
                top: height*0.05,
              right: width*0.05
            ),
            child: Row(
              children: [
                Container(
                  width: width*0.6,
                  child: WhiteTextRegular(title: 'FIND YOUR STORE NOW !'.tr(),
                      weight: FontWeight.w700, size: width*0.075),
                ),
                darktheme==false?
                Image.asset('images/logo.png',
                  width: width*.25,
                  fit: BoxFit.fill,
                )

                    :
                Image.asset('images/whitelogo.png',
                  width: width*.25,
                )
              ],
            ),
          ),
        ],
      ),

    );
  }
}
