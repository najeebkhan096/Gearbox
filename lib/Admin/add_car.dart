
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/dialogue.dart';
import 'package:gearbox/modal/car.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:gearbox/modal/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;




class AddCarScreen extends StatefulWidget {

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {






  List<String> storetype=[
    "Oil",
    "Wash",
    "Tires",
    "Spare Parts",
    "Tune / Ac"


  ];


  TextEditingController location=TextEditingController();
  XFile ? file;

  List<Uint8List> pickedImagesInBytes = [];


  _selectFile() async {
    FilePickerResult? fileResult =
    await FilePicker.platform.pickFiles(allowMultiple: true);

    if (fileResult != null) {


      setState(() {
        pickedImagesInBytes.add( fileResult.files.first.bytes!);
      });
   // await  uploadUint8List(fileResult.files.first.bytes!);


    }

  }


  Car ? newcar=Car(images: []);


  CollectionReference ? imgRef;
  bool isloading=false;

  firebase_storage.Reference ? ref;
  bool uploading=false;


  Future<void> uploadUint8List(Uint8List uint8list) async {

 

    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('cars/${DateTime.now().toString()}'); // Provide a unique identifier for the file name

      await ref!.putData(uint8list).whenComplete(() async {
        await ref!.getDownloadURL().then((value) async {
          if (value.isNotEmpty) {
            newcar!.images!.add(  value);


          }
        });
      });
    } catch (error) {

      setState(() {
        uploading = false;
        isloading = false;
      });
    }
  }

  List<String> getModelsForManufacturer(String manufacturer) {
    List<String> models = [];

    var selectedManufacturer = groupedCarModels.firstWhere(
          (carModel) => carModel['Manufacturer'] == manufacturer,
    );

    if (selectedManufacturer != null) {
      models = List<String>.from(selectedManufacturer['Models']);
    }

    return models;
  }


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Color(0xfff7f7f7),

      body: ListView(

        children: [
          Container(
              margin: EdgeInsets.only(left: width*.03,top: height*0.02),
              child: BlackTextBold(title: "Add Car", weight: FontWeight.w700, size:height*0.027 )),



          Container(
            margin: EdgeInsets.only(left: width*.03,top: height*0.005),
            child: Text("Add Car details  here",
              style: TextStyle(
                color: Color(0xffB4B4B4),
                fontSize: height*0.015,
              ),
            ),
          ),



          SizedBox(height: height*0.025,),
          LightPinkDropdown(hint: "Brand name", dropdownItems: groupedCarModels, onChanged: (val){

                setState(() {
                  newcar!.title=val;
      newcar!.modal=null;
                });
    },
            ),
          SizedBox(height: height*0.025,),


            if(newcar!.title!=null)
            LightPinkDropdownString(hint: "Modal",

              dropdownItems: getModelsForManufacturer(newcar!.title!), onChanged: (val){

            setState(() {
              newcar!.modal=val;
            });
          },
              selectedValue: newcar!.modal,

            ),
          if(newcar!.title!=null)
          SizedBox(height: height*0.025,),

          Container(
            margin: EdgeInsets.only(left: width*.03,top: height*0.025,
                right: width*0.025
            ),

            child: TextField(
              onChanged: (val){
                setState(() {
                  newcar!.phone=val;
                });
              },
              decoration: InputDecoration(
                labelText: 'Phone number',
                hintText: "Phone number",
                contentPadding: EdgeInsets.only(left: width*0.015),
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
          SizedBox(height: height*0.025,),
          Container(
            margin: EdgeInsets.only(left: width*.03,top: height*0.025,
                right: width*0.025
            ),

            child: TextField(
              onChanged: (val){
                setState(() {
                  newcar!.whatsno=val;
                });
              },
              decoration: InputDecoration(
                labelText: 'Whatsapp number',
                hintText: "Whatsapp number",
                contentPadding: EdgeInsets.only(left: width*0.015),
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
          SizedBox(height: height*0.025,),


          Container(
            margin: EdgeInsets.only(left: width*.03,top: height*0.025,
                right: width*0.025
            ),

            color: Color(0xffF9FAFE),

            child: TextField(
              onChanged: (val){
                setState(() {
                  newcar!.price=double.parse(val);
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(

                hintText: "Price",

                contentPadding: EdgeInsets.only(left: width*0.015),
                labelStyle: TextStyle(color: Colors.black),
                hintStyle:TextStyle(
                  color: Color(0xffAFAFAF),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins-Regular',
                ),

                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),


          SizedBox(height: height*0.025,),


          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: width*.03,top: height*0.005),
                child: Text("Description",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: height*0.015,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),


            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: width * 0.03,
                right: width * 0.025,
                top: height*0.02
            ),
            child: Row(
              children: [
                Container(
                  width: width*0.05,
                  color: Colors.black,
                  height: height*0.001,
                ),
                Expanded(
                  child: Container(
                    color: Color(0xffD9D9D9),
                    height: height*0.001,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height*0.025,),
          Container(
            margin: EdgeInsets.only(
              left: width * 0.03,
              right: width * 0.025,
            ),
            width: width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffF9FAFE),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: TextField(
              onChanged: (val){
                setState(() {
                  newcar!.description=val;
                });
              },
              maxLines: 8,
              decoration: InputDecoration(
                  hintText: "Description comes here",
                  hintStyle: TextStyle(
                      color: Color(0xffAFAFAF)
                  ),
                  contentPadding: EdgeInsets.only(left: width*0.015,top: height*.02),
                  labelStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none
              ),
            ),
          ),

          SizedBox(height: height*0.025,),

          Wrap(
            alignment: WrapAlignment.center,
            children: [

              Wrap(

                children:List.generate(pickedImagesInBytes.length  , (index) =>
                    Container(
                      width: 150,
                      height: 120,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Color(0xffF9FAFE),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: MemoryImage(pickedImagesInBytes[index]),
                          fit: BoxFit.fill
                          )
                      ),

                    )
              ),),
              InkWell(
                onTap: () async {
                  _selectFile();


                },
                child: Container(
                  width: 150,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Color(0xffF9FAFE),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.grey
                      )
                  ),
                  child: Center(
                    child: Text("Add a Photo",
                      style:TextStyle(
                        color: Color(0xffAFAFAF),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins-Regular',
                      ),

                    ),
                  ),
                )
              )
            ]
          ),

          SizedBox(height: height*0.025,),

          isloading?SpinKitCircle(
            color: Colors.black,
          ):
          InkWell(
            onTap: () async {
              setState(() {
                isloading=true;
              });
try{
  Future.forEach(pickedImagesInBytes, (Pickedelement) async{
    await  uploadUint8List(Pickedelement);
  } ).then((value) async{
    await database.addCar(mycar: newcar).then((value) {
      setState(() {
        isloading = false;
      });
      Navigator.of(context).pop();
    });
  });
}catch(error){
  setState(() {
    isloading=false;
  });
}




            },
            child: Container(
              height: height*0.058,
              width: 100,
              margin: EdgeInsets.only(left: 20,right: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Center(child: WhiteTextRegularNunita(title: "Add", weight: FontWeight.w500, size: height*0.023)
              ),
            ),
          ),
          SizedBox(height: height*0.1,),

        ],
      ),
    );
  }
}
