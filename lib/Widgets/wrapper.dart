import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gearbox/Auth/auth.dart';
import 'package:gearbox/Screens/service2.dart';
import 'package:gearbox/Screens/welcome.dart';
import 'package:gearbox/modal/database.dart';
import 'package:gearbox/modal/user.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:provider/provider.dart';


class Wrapper extends StatefulWidget {
  static const routename = 'Wrapper';

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);


    return StreamBuilder(
        stream: authservice.user,
        builder: (_, AsyncSnapshot<MyUser?> snapshot) {
          final MyUser? user = snapshot.data;

          return user == null ? WelcomeScreen():
FutureBuilder(

    future: database.fetch_desired_users(user.uid!),
    builder: (ctx,AsyncSnapshot<MyUser?> user_snaps){
      if(user_snaps.hasData){
        currentUser=user_snaps.data as MyUser?;
      }
      return
      (user_snaps.connectionState==ConnectionState.waiting
      && !user_snaps.hasData
      )?
          SpinKitCircle(color: Colors.white,)
          :
          ServiceScreen2();
    });



        });
  }
}

class LocationDeniedScreen extends StatelessWidget {
  final VoidCallback onRetry;

  LocationDeniedScreen({required this.onRetry});

  Future<PermissionStatus> checkStatusLocationPermission(
      BuildContext context) async {
    var status = await Permission.location.status;
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Permission Denied'),
      ),
      body: FutureBuilder(
        future: checkStatusLocationPermission(context),
        builder:
            (ctx, AsyncSnapshot<PermissionStatus> permissionSnapshot) {
          if (permissionSnapshot.connectionState ==
              ConnectionState.waiting &&
              !permissionSnapshot.hasData) {
            return SpinKitCircle(color: Colors.white);
          }

          // Check permission statuses
          bool isGranted = permissionSnapshot.data == PermissionStatus.granted;
          bool isDenied = permissionSnapshot.data == PermissionStatus.denied;
          bool isRestricted = permissionSnapshot.data == PermissionStatus.restricted;
          bool isUndetermined = permissionSnapshot.data == PermissionStatus.limited;

          // Check if permission is permanently denied
          bool isPermanentlyDenied =
              permissionSnapshot.data == PermissionStatus.permanentlyDenied;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isGranted)
                  Text('Location Permission is granted.'),
                if (isDenied)
                  Text('Location Permission is denied.'),
                if (isRestricted)
                  Text('Location Permission is restricted.'),
                if (isUndetermined)
                  Text('Location Permission is limited.'),
                if (isPermanentlyDenied)
                  Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Text('Location Permission is permanently denied.\nPlease go to app settings and enable location manually.',
                        textAlign: TextAlign.center,
                      )),
                SizedBox(height: 20),
                if (isPermanentlyDenied==false)
                ElevatedButton(
                  onPressed: onRetry,
                  child: Text('Retry and Allow Location'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}