import 'package:flutter/material.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapScreen({required this.latitude, required this.longitude});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: darktheme ? bgcolor : darkblue,
        elevation: 0,
        centerTitle: true,
        title: WhiteTextRegular(
          title: tr('current_location_title'),
          weight: FontWeight.w600,
          size: width * 0.038,
        ),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 14.0,
        ),
        markers: <Marker>[
          Marker(
            markerId: MarkerId('currentLocation'),
            position: LatLng(widget.latitude, widget.longitude),
            infoWindow: InfoWindow(
              title: tr('current_location_marker_title'),
            ),
          ),
        ].toSet(),
      ),
    );
  }
}
