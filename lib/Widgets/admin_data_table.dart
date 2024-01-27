import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart'; // Import Easy Localization
import 'package:gearbox/Widgets/text.dart';

class RecruitmentDataWidget extends StatefulWidget {
  @override
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
  final CollectionReference storesCollection =
  FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
        left: width * 0.03,
        right: width * 0.025,
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      child: FutureBuilder<QuerySnapshot>(
        future: storesCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                height: 300,
                width: 100,
                child: Center(
                  child: SpinKitCircle(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;

          return documents.isEmpty
              ? Container(
            height: 350,
            child: Center(child: Text("No Car")),
          )
              : Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: List.generate(documents.length + 1, (index) {
              return index == 0
                  ? TableRow(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                children: [
                  tableHeader("Name"),
                  tableHeader("Email"),
                  tableHeader("Location"),
                  tableHeader("Role"),
                  tableHeader("Car Brand"),
                  tableHeader("Phone no"),
                  tableHeader("Modal Type"),
                  tableHeader("Promo"),
                ],
              )
                  : tableRow(
                context,
                name: documents[index - 1]['username'],
                image: documents[index - 1]['imageurl'],
                email: documents[index - 1]['email'],
                location: "Helsinki",
                role: "Owner",
                servicetype: documents[index - 1]['car_brand'],
                phone_no: "+921234556677",
                modaltype: documents[index - 1]["car_modal"],
              );
            }),
          );
        },
      ),
    );
  }

  TableRow tableRow(context,
      {name, image, email, location, role, servicetype, phone_no, modaltype}) {
    return TableRow(children: [
      Container(
        padding: EdgeInsets.only(top: 20),
        child: Wrap(
          children: [
            image.toString().isEmpty
                ? CircleAvatar(
              radius: 15,
              child: Center(
                child: Text(
                  "No Image",
                  style: TextStyle(fontSize: 5),
                ),
              ),
            )
                : CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(image),
            ),
            SizedBox(width: 10),
            Text(
              name,
            ),
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            email,
            style: TextStyle(
                color: Color(0xff232323).withOpacity(0.5),
                fontSize: MediaQuery.of(context).size.height * 0.016),
          )),
      Container(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            location,
            style: TextStyle(
                color: Color(0xff232323).withOpacity(0.5),
                fontSize: MediaQuery.of(context).size.height * 0.016),
          )),
      Container(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            role,
            style: TextStyle(
                color: Color(0xff232323).withOpacity(0.5),
                fontSize: MediaQuery.of(context).size.height * 0.016),
          )),
      Container(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            servicetype,
            style: TextStyle(
                color: Color(0xff232323).withOpacity(0.5),
                fontSize: MediaQuery.of(context).size.height * 0.016),
          )),
      Container(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            phone_no,
            style: TextStyle(
                color: Color(0xff232323).withOpacity(0.5),
                fontSize: MediaQuery.of(context).size.height * 0.016),
          )),
      Container(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            modaltype,
            style: TextStyle(
                color: Color(0xff232323).withOpacity(0.5),
                fontSize: MediaQuery.of(context).size.height * 0.016),
          )),
      Container(
        padding: EdgeInsets.only(top: 20),
        child: Wrap(
          children: [
            Container(
              height: 35,
              width: 80,
              decoration: BoxDecoration(
                  color: Color(0xffEC441E),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: WhiteTextRegularNunita(
                      title: "Add promo",
                      weight: FontWeight.w500,
                      size: MediaQuery.of(context).size.height * 0.0145)),
            ),
            SizedBox(
              width: 30,
            ),
            Icon(
              Icons.more_vert,
              color: Color(0xff1B1D2A).withOpacity(0.5),
              size: MediaQuery.of(context).size.height * 0.0145,
            )
          ],
        ),
      ),
    ]);
  }

  Widget tableHeader(text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text.tr(), // Use translations
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.height * 0.016,
        ),
      ),
    );
  }
}
