import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gearbox/Screens/googlemap.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gearbox/Widgets/button.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:gearbox/modal/database.dart';
import 'package:gearbox/modal/store.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;




class AddStoreScreen extends StatefulWidget {

  @override
  State<AddStoreScreen> createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {



List<String> storetype=[
  "Oil",
  "Wash",
  "Tires",
  "Spare Parts",
  "Tune / Ac"


];


TextEditingController location=TextEditingController();
XFile ? file;
Uint8List ? selectedImageInBytes;
List<Uint8List> pickedImagesInBytes = [];


_selectFile() async {
  FilePickerResult? fileResult =
  await FilePicker.platform.pickFiles(allowMultiple: true);

  if (fileResult != null) {


  setState(() {
    selectedImageInBytes=fileResult.files.first.bytes;
  });
  }

}
Store ? newstore=Store(brands: []);


CollectionReference ? imgRef;
bool isloading=false;

firebase_storage.Reference ? ref;
bool uploading=false;

Future<String?> upload_my_file({File ? myfile}) async {
  String ? got_image;
  ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child('${"profile"}/${Path.basename(myfile!.path)}');
  await ref!.putFile(myfile).whenComplete(() async {
    await ref!.getDownloadURL().then((imageurl) {

      if(imageurl!=null){
        got_image=imageurl;
      }

    });
  });

  return got_image;
}

Future<void> uploadUint8List(Uint8List uint8list) async {

  setState(() {
    isloading = true;
  });

  try {
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('stores/${DateTime.now().toString()}'); // Provide a unique identifier for the file name

    await ref!.putData(uint8list).whenComplete(() async {
      await ref!.getDownloadURL().then((value) async {
        if (value.isNotEmpty) {
          newstore!.image = value;

          await database.addStore(mystore: newstore).then((value) {
            setState(() {
              isloading = false;
            });
            Navigator.of(context).pop();
          });
        }
      });
    });
  } catch (error) {
    print("error is "+error.toString());

    setState(() {
      uploading = false;
      isloading = false;
    });
  }
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
              child: BlackTextBold(title: "Add Store", weight: FontWeight.w700, size:height*0.027 )),



          Container(
            margin: EdgeInsets.only(left: width*.03,top: height*0.005),
            child: Text("Add store details  here",
            style: TextStyle(
              color: Color(0xffB4B4B4),
              fontSize: height*0.015,
            ),
            ),
          ),


          Container(
            margin: EdgeInsets.only(left: width*.03,top: height*0.025,
            right: width*0.025
            ),

            child: TextField(
              onChanged: (val){
                setState(() {
                  newstore!.title=val;
                });
              },
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: "Store Title",
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


          LightPinkDropdown(hint: "Brand name", dropdownItems: groupedCarModels, onChanged: (val){

            newstore!.brands!.add(val.toString());
            setState(() {

            });

          }),

          if(newstore!.brands!.length>0)
            Wrap(
              children: List.generate(newstore!.brands!.length, (index) =>
                  Stack(
                    children: [
                      IntrinsicWidth(
                        child: Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          margin: EdgeInsets.only(
                            left:index==0?40: 20,
                            top: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffF9FAFE),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          height: height*0.056,
                          child: Center(
                            child: Text(
                              newstore!.brands![index].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Regular',
                                color: Color(0xffAFAFAF),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 8,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              newstore!.brands!.removeAt(index);
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 8,
                            child: Center(child: Icon(Icons.delete, color: Colors.white, size: 11.5)),
                          ),
                        ),
                      )
                    ],
                  ),
              ),
            )
,

          SizedBox(height: height*0.025,),


         LightPinkDropdownString(hint: "Type of Store", dropdownItems: storetype, onChanged: (val){

             setState(() {
               newstore!.type=val;
             });

         }),

          SizedBox(height: height*0.025,),

          LightPinkDropdownString(hint: "Store Status", dropdownItems: const ["true","false"], onChanged: (val){

              setState(() {
                newstore!.status=val;
              });

          }),

          SizedBox(height: height*0.025,),

          Container(
            margin: EdgeInsets.only(left: width*.03,top: height*0.025,
                right: width*0.025
            ),

            child: TextField(

              onChanged: (val){

              },
              controller: location,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                  return PlaceAutocompleteScreen();
                })).then((value) {
                  if(value!=null && value.toString().isNotEmpty){

                    setState(() {
                      newstore!.location=value;
                      location.text=value;
                    });
                  }
                });
              },
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: "Enter you location",
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
                  newstore!.phone_no=val;
                });
              },
              decoration: InputDecoration(

                hintText: "Phone number",
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
          Container(
            margin: EdgeInsets.only(left: width*.03,top: height*0.025,
                right: width*0.025
            ),

            color: Color(0xffF9FAFE),

            child: TextField(
              onChanged: (val){
                setState(() {
                  newstore!.whatsapp=val;
                });
              },
              decoration: InputDecoration(

                hintText: "Whatsapp number",
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
          InkWell(
            onTap: (){
              _selectFile();
            },
            child : Center(
              child:
           selectedImageInBytes==null?
              Container(
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
              ):
                  Container(
                    width: 150,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Color(0xffF9FAFE),
                        borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: MemoryImage(selectedImageInBytes!))
                    ),

                  )
              ,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: width*.03,top: height*0.005),
                child: Text("View more",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: height*0.015,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ],
          ),

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
              Container(
                margin: EdgeInsets.only(left: width*.03,top: height*0.005),
                child: Text("Attachment",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: height*0.015,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: width*.03,top: height*0.005),
                child: Text("Responsible",
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
                  newstore!.description=val;
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
          Container(
            margin: EdgeInsets.only(
              left: width * 0.03,
              right: width * 0.025,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: height*0.058,
                  width: 100,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border:Border.all( color:Colors.black),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(child: BlackTextRegular(title: "Cancel", weight: FontWeight.w500, size: height*0.023)
                  ),
                ),
                SizedBox(width: width*0.025,),

                isloading?SpinKitCircle(
                  color: Colors.black,
                ):
                InkWell(
                  onTap: () async {

                     await uploadUint8List(selectedImageInBytes!);


                  },
                  child: Container(
                    height: height*0.058,
                    width: 100,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Center(child: WhiteTextRegularNunita(title: "Add", weight: FontWeight.w500, size: height*0.023)
                    ),
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height: height*0.1,),

        ],
      ),
    );
  }
}
