import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gearbox/Admin/add_car.dart';
import 'package:gearbox/Admin/add_store.dart';
import 'package:gearbox/Admin/mycars.dart';
import 'package:gearbox/Admin/user_managment.dart';
import 'package:gearbox/Screens/mycars.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:multi_pile_faces/multi_pile_faces.dart';

class DashboardScreen extends StatefulWidget {
  static const routename = "DashboardScreen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _allUsers = <FaceHolder>[
    FaceHolder(
      id: '0',
      name: 'first user',
      avatar: const NetworkImage(
          "https://qph.cf2.quoracdn.net/main-qimg-eb6b82103ec41215cab0d61d958766f7-lq"),
    ),
    FaceHolder(
      id: '1',
      name: 'second user',
      avatar: const NetworkImage(
          "data:image/jpeg;base64,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"),
    ),
    FaceHolder(
      id: '2',
      name: 'third user',
      avatar: const NetworkImage(
          "data:image/jpeg;base64,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"),
    ),
    FaceHolder(
        id: '3',
        name: 'fourth user',
        avatar: const NetworkImage(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ_tZqDgmHkzjFIuvCFBHWrD-eVx1w_d-38Q&usqp=CAU",
        )),
  ];
// Function to delete a document from the "stores" collection
  Future<void> deleteStore(String documentId) async {
    await storesCollection.doc(documentId).delete();
    print('Document $documentId deleted successfully');
  }

  Future<void> updateFieldToDisabled(String documentId, bool disable) async {
    // Assuming you have initialized Firestore somewhere in your code
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Reference to the document you want to update
      DocumentReference documentReference =
          firestore.collection('Stores').doc(documentId);

      // Update the "disabled" field to true
      await documentReference.update({'disabled': !disable});

      print(
          'Document with ID $documentId updated successfully. Field "disabled" set to true.');
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  int calculateDaysDifference(DateTime startDate, DateTime endDate) {
    // Calculate the difference between the two dates
    Duration difference = endDate.difference(startDate);

    // Convert the duration to days and return the result
    return difference.inDays;
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlackTextRegular(
                  title: "Filters", weight: FontWeight.w500, size: 20),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    "images/close.png",
                    height: 20,
                    width: 20,
                  ))
            ],
          ),
          content: Container(
            height: 300,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlackTextRegular(
                          title: "Name", weight: FontWeight.w500, size: 15),
                      SizedBox(
                        width: 80,
                      ),
                      _buildDropdown('Dropdown 1'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlackTextRegular(
                          title: "Name", weight: FontWeight.w500, size: 15),
                      SizedBox(
                        width: 80,
                      ),
                      _buildDropdown('Dropdown 1'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlackTextRegular(
                          title: "Name", weight: FontWeight.w500, size: 15),
                      SizedBox(
                        width: 80,
                      ),
                      _buildDropdown('Dropdown 1'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdown(String title) {
    return Container(
      height: 30,
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgcolor,
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: DropdownButton<String>(
        iconEnabledColor: Colors.white,
        hint: WhiteTextRegular(title: "All", weight: FontWeight.w500, size: 15),
        style: TextStyle(color: Colors.white), // Text color
        dropdownColor: Colors.black, // Dropdown background color
        items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // Handle dropdown value change
        },
        underline: Container(), // Hide underline
      ),
    );
  }

  final CollectionReference storesCollection =
      FirebaseFirestore.instance.collection('Stores');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: darktheme ? bgcolor : darkblue,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return UserManagementScreen();
              }));
            },
            child: Padding(
              padding: EdgeInsets.only(right: width * 0.035),
              child: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    "https://static.standard.co.uk/2023/07/05/14/newFile.jpg?width=1200&height=1200&fit=crop"),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
              margin: EdgeInsets.only(left: width * .03, top: height * 0.025),
              child: BlackTextBold(
                  title: "Current Stores",
                  weight: FontWeight.w700,
                  size: height * 0.025)),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        right: width * 0.025, left: width * 0.005),
                    margin: EdgeInsets.only(
                      left: width * 0.03,
                      right: width * 0.025,
                    ),
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: darktheme ? bgcolor : Colors.white,
                      border: Border.all(
                        color: darktheme ? Colors.white24 : Colors.black12,
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xff566D7F),
                          ),
                          hintText: "Search Stores by name, city ....",
                          hintStyle: TextStyle(
                              color: Color(0xff566D7F),
                              fontSize: height * .0125)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _showPopup(context);
                    },
                    child: Container(
                      height: height * 0.050,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Color(0xff1B1D2A),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Image.asset(
                        "images/filter.png",
                        height: height * 0.018,
                      )),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return AdminCarsScreen();
                      }));
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: width * 0.025),
                        height: height * 0.050,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Color(0xff1B1D2A),
                            borderRadius: BorderRadius.circular(5)),
                        child: WhiteTextRegularNunita(
                            title: "My Cars",
                            weight: FontWeight.w500,
                            size: height * 0.01)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return AddCarScreen();
                      }));
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: width * 0.025),
                        height: height * 0.050,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Color(0xff1B1D2A),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: height * .018,
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            WhiteTextRegularNunita(
                                title: "Add Car",
                                weight: FontWeight.w500,
                                size: height * 0.01)
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return AddStoreScreen();
                      }));
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: width * 0.025),
                        height: height * 0.050,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Color(0xff1B1D2A),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: height * .018,
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            WhiteTextRegularNunita(
                                title: "Add store",
                                weight: FontWeight.w500,
                                size: height * 0.01)
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: height * 0.015,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: storesCollection.snapshots(),
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

              return Container(
                margin: EdgeInsets.only(
                  bottom: height * 0.02,
                  left: width * 0.025,
                  right: width * 0.025,
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 5,
                  runSpacing: 7,
                  children: List.generate(documents.length, (index) {
                    Map<String, dynamic> data =
                        documents[index].data() as Map<String, dynamic>;
                    return InkWell(
                      onTap: () {},
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: 380,
                          padding: EdgeInsets.only(
                              left: width * .0075,
                              right: width * .0075,
                              top: height * .02,
                              bottom: height * .02),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data['image'],
                                fit: BoxFit.fill,
                                height: height * 0.15,
                                width: width * 1,
                              ),
                              SizedBox(
                                height: height * 0.0085,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlackTextRegular(
                                      title: data['title'],
                                      weight: FontWeight.w600,
                                      size: height * 0.02),
                                  PopupMenuButton<String>(
                                    icon: Icon(Icons.more_vert),
                                    color: Color(0xff232323),
                                    onSelected: (value) {
                                      // Perform action based on the selected menu item
                                      if (value == 'item1') {
                                        // Do something for item 1
                                      } else if (value == 'item2') {
                                        // Do something for item 2
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'item1',
                                          child: Text(
                                            'Edit Store',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'item2',
                                          onTap: () async {
                                            await deleteStore(
                                                    documents[index].id)
                                                .then((value) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Stored Successfully")));
                                            });
                                          },
                                          child: Text(
                                            'Remove Store',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'item2',
                                          onTap: () async {
                                            await updateFieldToDisabled(
                                                    documents[index].id,
                                                    data['disabled'])
                                                .then((value) {
                                              setState(() {});
                                            });
                                          },
                                          child: Text(
                                            data['disabled'] == null
                                                ? "Disable"
                                                : data['disabled']
                                                    ? 'Enable Store'
                                                    : 'Disable Store',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'item2',
                                          child: Text(
                                            'Store Offers',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.0025,
                              ),
                              BlackTextRegular(
                                  title: data['location'],
                                  weight: FontWeight.w400,
                                  size: height * 0.02),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BlackTextRegular(
                                      title: "Progress",
                                      weight: FontWeight.w600,
                                      size: height * 0.02),
                                  BlackTextRegular(
                                      title: "85%",
                                      weight: FontWeight.w500,
                                      size: height * 0.02),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.0085,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: LinearProgressIndicator(
                                  value: 0.8,
                                  color: Colors.grey,
                                  backgroundColor: Color(0xff1B1D2A33),
                                  minHeight: height * 0.015,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "images/admin/clock.png",
                                        height: height * .025,
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      BlackTextRegular(
                                        title: calculateDaysDifference(
                                                (data['date'] as Timestamp)
                                                    .toDate(),
                                                DateTime.now())
                                            .toString(),
                                        weight: FontWeight.w500,
                                        size: height * 0.02,
                                      ),
                                    ],
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 100),
                                    child: FacePile(
                                      faces: _allUsers,
                                      faceSize: height * 0.035,
                                      facePercentOverlap:
                                          .4, // 40% face overlap.
                                      borderColor: Colors.white,
                                      nameLabelColor: Colors.black,
                                      borderWidth: 0.4,
                                      animationDuration:
                                          const Duration(milliseconds: 500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
          SizedBox(
            height: height * 0.025,
          ),
        ],
      ),
    );
  }

  Widget BuildBanner(context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.22,
      width: width * 1,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "images/pic2.png",
              ),
              fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: width * 0.075, top: height * 0.05),
            child: Row(
              children: [
                Container(
                  width: width * 0.6,
                  child: WhiteTextRegular(
                      title: 'FIND NEAREST STORES NOW !',
                      weight: FontWeight.w700,
                      size: width * 0.075),
                ),
                darktheme == false
                    ? Image.asset(
                        'images/logo.png',
                        width: width * .25,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        'images/whitelogo.png',
                        width: width * .25,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
