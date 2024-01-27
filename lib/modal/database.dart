import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/modal/car.dart';
import 'package:gearbox/modal/store.dart';
import 'package:gearbox/modal/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Database{


  Future<String> adduser(
      {MyUser ? mySelf}) async {
    Map<String, dynamic> data = {
      'username': mySelf!.username,
      'email': mySelf.email,
      'userid': mySelf.uid,
      'imageurl': "",
      'date': DateTime.now(),
      'car_modal':mySelf.carModal,
      'car_brand':mySelf.CarBrand
    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result = await collection.add(data);
    return result.id;
  }

  Future<String> addStore(
      {required Store ? mystore}) async {
    Map<String, dynamic> data = {
      'title': mystore!.title,
      'type': mystore.type,
      'status': mystore.status,
      'location': mystore.location,
      "phone":mystore.phone_no,
      "whatsapp":mystore.whatsapp,
      "image":mystore.image,
      "date":DateTime.now(),
      "description":mystore.description,
      "disabled":false,
      "brands":mystore.brands
    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Stores');
    final result = await collection.add(data);
    return result.id;
  }
  Future<String> addCar(
      {required Car ? mycar}) async {
    Map<String, dynamic> data = {
      'title': mycar!.title,
      'price':mycar.price,
      "images":mycar.images,
      "date":DateTime.now(),
      "description":mycar.description,
      'phone':mycar.phone,
      'whatsapp':mycar.whatsno,
      'modal':mycar.modal

    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Cars');
    final result = await collection.add(data);
    return result.id;
  }

  Future<MyUser?> fetch_desired_users(String desireduserid) async {
    MyUser ? desireduser;
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {

        Map<dynamic, dynamic> fetcheddata =
        element.data() as Map<dynamic, dynamic>;



        if(desireduserid==fetcheddata['userid']){

          Timestamp stamp = fetcheddata['date'];

          desireduser=MyUser(
              docid: element.id,
              email: fetcheddata['email'],
              uid: fetcheddata['userid'],
              username: fetcheddata['username'],
              date: stamp.toDate(),
              imageurl: fetcheddata['imageurl'].toString(),
            carModal: fetcheddata["car_modal"].toString(),
            CarBrand: fetcheddata["car_brand"].toString()
            // device_id: fetcheddata["device_id"].toString()

          );
        }

      });
    });
    return desireduser;
  }


  Future<Map?> fetch_admin_credential() async {
    Map<dynamic, dynamic> ? data;
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Admin');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {

        Map<dynamic, dynamic> fetcheddata = element.data() as Map<dynamic, dynamic>;

data=fetcheddata;


      });
    });
return data;
  }
  int findManufacturerIndex(String manufacturer) {
    for (int i = 0; i < groupedCarModels.length; i++) {
      if (groupedCarModels[i]['Manufacturer'] == manufacturer) {
        return i;
      }
    }
    return -1; // Return -1 if the manufacturer is not found
  }
  Future<UserCredential?> signInWithGoogle() async {
    final _googleSignIn = GoogleSignIn();
    await _googleSignIn.disconnect().catchError((e, stack) {
      print(e);
    });

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();


    // handling the exception when cancel sign in
    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<bool> CheckUserExistance (String loggeduserid) async {

    bool exist=false;

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {

        Map fetcheddata = element.data() as Map<String, dynamic>;

        if(fetcheddata['userid']==loggeduserid){
          exist=true;
        }
      });
    });


    return exist;
  }
}
Database database=Database();