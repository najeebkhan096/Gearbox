import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gearbox/Screens/CarDetailsScreen.dart';
import 'package:gearbox/Widgets/bottom_nab_bar.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/dialogue.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:gearbox/modal/emergency.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatefulWidget {

  EmergencyScreen();
  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  List<int> parsePriceRange(String selectedPriceRange) {
    // Remove non-numeric characters and split the range
    List<String> parts =
    selectedPriceRange.replaceAll(RegExp(r'[^0-9-]'), '').split('-');

    // Parse the start and end values
    int start = int.parse(parts[0]); // convert to int
    int end = int.parse(parts[1]); // convert to int

    return [start, end];
  }
  List<String> data = [
    "Ambulance",
    "Winch",
    "Police"
  ];
  void _makePhoneCall(int phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber.toString(),
    );
    await launchUrl(launchUri);
  }
  Emergency ? emergency;
@override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
  await Emergency.fetchEmergencyData().then((val){

    setState(() {
      emergency=val;
    });
  });

  super.didChangeDependencies();
  }


  final CollectionReference storesCollection =
  FirebaseFirestore.instance.collection('Emergency');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(),
      backgroundColor: darktheme ? bgcolor : Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: darktheme ? bgcolor : Color(0xff0D1B2B),
        centerTitle: true,
        title: WhiteTextRegular(
          title: 'Emergency'.tr(),
          weight: FontWeight.w700,
          size: width * 0.035,
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: height * 0.045,
          ),

          SizedBox(
            height: height * 0.025,
          ),
         
          Column(
            children: [
              InkWell(
                onTap: () async{
                if(emergency!=null)
                  _makePhoneCall(emergency!.ambulance);

                },
                child: Container(
                  padding: const EdgeInsets.all(20),
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

                            : const Color(0xffC2CCD8),
                      ),
                      borderRadius: BorderRadius.circular(40)),
                  child: Container(
                    padding:
                    EdgeInsets.only(right: width * 0.25),
                    child: Text(
                      "Ambulance".toString().tr(),
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
                ),
              ),

              Container(
                padding: const EdgeInsets.all(1),
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

                          : const Color(0xffC2CCD8),
                    ),
                    borderRadius: BorderRadius.circular(40)),
                child: Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(

                    title:
                  Text(
                    "Winch".toString().tr(),
                    style: TextStyle(
                      fontSize: width * 0.034,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Nunito-Regular',
                      color: darktheme
                          ? Colors.grey
                          : const Color(0xff535865),
                    ),
                  ),

                    children:

                    emergency==null?[]:
                    List.generate(emergency!.winch.length, (index){
                      WinchModal _winch =emergency!.winch[index];
                      return  ListTile(
                        onTap: (){
                          _makePhoneCall(_winch.number);
                        },
                        title: Text('Location : '+_winch.location),
                        subtitle: Text('Contact : '+_winch.number.toString()),
                      );
                    })
                  ),
                )
              ),

              InkWell(
                onTap: () async{
                  if(emergency!=null)

                  _makePhoneCall(emergency!.police);

                },
                child: Container(
                  padding: const EdgeInsets.all(20),
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

                            : const Color(0xffC2CCD8),
                      ),
                      borderRadius: BorderRadius.circular(40)),
                  child: Container(
                    padding:
                    EdgeInsets.only(right: width * 0.25),
                    child: Text(
                      "Police".toString().tr(),
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
                ),
              ),
              
            ],
          ),
          
          
          SizedBox(
            height: height * 0.025,
          ),
        ]),
      ),
    );
  }
}
