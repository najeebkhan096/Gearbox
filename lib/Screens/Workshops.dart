import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gearbox/Screens/workshopDetails.dart';
import 'package:gearbox/Widgets/CityCountryText.dart';
import 'package:gearbox/Widgets/bottom_nab_bar.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class WorkshopsScreen extends StatelessWidget {

  Future<List<Placemark>> _determinePlacemarks() async {
    Position currentPosition = await _determinePosition();

    return placemarkFromCoordinates(
      currentPosition.latitude,
      currentPosition.longitude,
    );
  }
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

      return null; // Handle errors
    }
  }
  Future<Position> _determinePosition() async {
    // Your implementation to get the current position
    // This could involve using the geolocator package or another location service
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
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

  Map<String, String> getCityAndCountryCode(String fullAddress) {
    // Regular expression to match city name (assumes city is followed by a comma)
    RegExp cityRegex = RegExp(r',\s*([^,]+)');
    // Regular expression to match country code (assumes two uppercase letters before a space or the end of the string)
    RegExp countryCodeRegex = RegExp(r'([A-Z]{2})\s*');

    String city = cityRegex.stringMatch(fullAddress)?.trim() ?? "";
    String countryCode = countryCodeRegex.stringMatch(fullAddress)?.trim() ?? "";

    return {'city': city, 'countryCode': countryCode};
  }

  final CollectionReference storesCollection =
  FirebaseFirestore.instance.collection('Stores');

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(),
      backgroundColor: darktheme?bgcolor:Colors.white,
      appBar: AppBar(
        backgroundColor:darktheme?bgcolor:darkblue,

        leading: Icon(Icons.menu,color: Colors.white,),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: width*0.035),
            child: Icon(Icons.search,color: Colors.white,),
          )
        ],
        centerTitle: true,
        title: WhiteTextRegular(
          title: 'workshops'.tr(), // Use translations
          weight: FontWeight.w600,
          size: width * 0.038,
        ),
      ),
      body: ListView(

        children: [

          SizedBox(height: height*0.025,),
          Container(
            margin: EdgeInsets.only(
              left: width*0.1,
              right: width*0.1
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Row(
                children: [
                  Image.asset('images/Filter_alt.png',width: width*0.035,),
      SizedBox(width: width*0.025,),
      GreyTextRegular(title: 'filter'.tr(), weight: FontWeight.w600, size: width*0.032),

                ],
              ),

                Row(
                  children: [
                    Image.asset('images/Pin_duotone.png',width: width*0.035,),
                    SizedBox(width: width*0.01,),

                    FutureBuilder<List<Placemark>>(
                      future: _determinePlacemarks(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text(""); // Show loading indicator while fetching data
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          return CityCountryText(placemarks: snapshot.data!);
                        } else {
                          return Text("Could not determine current position.");
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),


          SizedBox(height: height*0.025,),
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

              // Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
              // return ListView.builder(
              // itemCount: documents.length,
              // itemBuilder: (context, index) {
              // // Access data from the document
              // Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
              // String storeName = data['name'];
              //
              // // Display the store name in a ListTile
              // return ListTile(
              // title: Text(storeName),
              // );
              // },
              // );

              return     Container(
                height: height*1,
                margin: EdgeInsets.only(left: width*0.04,right: width*0.04),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: height*0.31,
                      crossAxisSpacing: width*.025
                    // Number of items in each row
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: documents.length,

                  // Number of items you want to display
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                    // Generate your items here
                    return InkWell(
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
                    );
                  },

                ),
              );

            },
          ),

          SizedBox(height: height*0.025,),

        ],
      ),
    );
  }

}
