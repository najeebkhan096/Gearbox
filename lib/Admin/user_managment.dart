import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:gearbox/Widgets/admin_data_table.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';


class UserManagementScreen extends StatelessWidget {

  final CollectionReference storesCollection =
  FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:const Color(0xfff7f7f7),

      appBar: AppBar(
        backgroundColor:darktheme?bgcolor:darkblue,
        elevation: 0,

        actions: [
          Padding(
            padding:  EdgeInsets.only(right: width*0.035),
            child: const CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage("https://static.standard.co.uk/2023/07/05/14/newFile.jpg?width=1200&height=1200&fit=crop"),
            ),
          )
        ],


      ),
      body: ListView(

        children: [
          Container(
              margin: EdgeInsets.only(left: width*.03,top: height*0.022),
              child: BlackTextBold(title: "User Management", weight: FontWeight.w700, size:height*0.027 )),
          SizedBox(height: height*0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: width*0.025,
                        left: width*0.005
                    ),
                    margin: EdgeInsets.only(
                      left: width * 0.03,
                      right: width * 0.025,
                    ),
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:    darktheme?bgcolor:Colors.white,
                      border: Border.all(
                        color:
                        darktheme?
                        Colors.white24
                            :
                        Colors.black12,
                      ),
                    ),

                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search,color: Color(0xff566D7F),),
                          hintText: "Search Stores by name, city ....",
                          hintStyle: TextStyle(
                              color: const Color(0xff566D7F),
                              fontSize: height*.0125
                          )
                      ),
                    ),
                  ),

                  Container(
                    height: height*0.050,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xff1B1D2A),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(child: Image.asset("images/filter.png",
                      height: height*0.018,
                    )),
                  )
                ],
              ),


            ],
          ),


          SizedBox(height: height*0.015,),
          RecruitmentDataWidget()

        ],
      ),
    );
  }

}
