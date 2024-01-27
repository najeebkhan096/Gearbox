import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gearbox/Widgets/bottom_nab_bar.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class PinLocationScreen extends StatefulWidget {
  @override
  _PinLocationScreenState createState() => _PinLocationScreenState();
}

class _PinLocationScreenState extends State<PinLocationScreen> {
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTap(LatLng tappedPoint) async {
    // Handle tapping on the map to update the pin location
    setState(() {
      currentLocation = tappedPoint;
    });

    // Reverse geocode to get the address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      tappedPoint.latitude,
      tappedPoint.longitude,
    );

    // Print the address to the console (you can display it in your UI)
    if (placemarks.isNotEmpty) {
      print('Address: ${placemarks.first.name}, ${placemarks.first.locality}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(),
      backgroundColor: darktheme ? const Color(0xff1c1c1c) : const Color(0xffD5D6D8),
      appBar: AppBar(
        title: WhiteTextRegular(
          title: tr('pin_location.title'),
          weight: FontWeight.w600,
          size: width * 0.038,
        ),
        backgroundColor: darktheme ? bgcolor : darkblue,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onTap: _onMapTap,
        initialCameraPosition: CameraPosition(
          target: currentLocation!,
          zoom: 15.0,
        ),
        markers: {
          Marker(
            markerId: MarkerId('pin'),
            position: currentLocation!,
            draggable: true,
            onDragEnd: (newPosition) {
              // Handle dragging the marker to update the location
              setState(() {
                currentLocation = newPosition;
              });
            },
          ),
        },
      ),
    );
  }
}
