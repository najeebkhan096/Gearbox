import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gearbox/Screens/CarDetailsScreen.dart';
import 'package:gearbox/Widgets/bottom_nab_bar.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/dialogue.dart';
import 'package:gearbox/Widgets/text.dart';

class MyCarsScreen extends StatefulWidget {
  final bool ? emergency;
  MyCarsScreen({required this.emergency});
  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  List<int> parsePriceRange(String selectedPriceRange) {
    // Remove non-numeric characters and split the range
    List<String> parts =
    selectedPriceRange.replaceAll(RegExp(r'[^0-9-]'), '').split('-');

    // Parse the start and end values
    int start = int.parse(parts[0]); // convert to int
    int end = int.parse(parts[1]); // convert to int

    return [start, end];
  }

  @override
  void initState() {
    // TODO: implement initState
    currentIndex = 1;
    super.initState();
  }

  final CollectionReference storesCollection =
  FirebaseFirestore.instance.collection('Cars');

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
          title: 'my_cars.title'.tr(),
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
          InkWell(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) => FilterDialog(),
              ).then((value) {
                print("value is " + value.toString());
                setState(() {});
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 30,right: 30),
              child: Row(
                children: [
                  Image.asset('images/Filter_alt.png', width: width * 0.035),
                  SizedBox(width: width * 0.025),
                  GreyTextRegular(
                    title: 'my_cars.filter'.tr(),
                    weight: FontWeight.w600,
                    size: width * 0.032,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          FutureBuilder<QuerySnapshot>(
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

              // Filter documents based on selectedManufacturer and selectedPriceRange
              if (selectedManufacturer != null) {
                documents = documents
                    .where((element) => element['title'] == selectedManufacturer)
                    .toList();
              }
              if (selectedModel != null) {
                documents = documents
                    .where((element) => element['modal'] == selectedModel)
                    .toList();
              }
              if (selectedPriceRange != null) {
                final priceRange = parsePriceRange(selectedPriceRange!);

                documents = documents
                    .where((element) {
                  final price = element['price'];
                  return price != null &&
                      price is int &&
                      price >= priceRange[0] &&
                      price <= priceRange[1];
                })
                    .toList();
              }

              return documents.isEmpty
                  ? Container(
                height: 350,
                child: Center(child: Text("my_cars.no_car".tr())),
              )
                  : Column(
                children: List.generate(documents.length, (index) {
                  Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return CarDetailScreen(car: data);
                          },
                        ),
                      );
                    },
                    child: Card(
                      color: darktheme ? bgcolor : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: darktheme
                                ? const Color(0xff3D3D3D)
                                : Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(
                        left: width * 0.065,
                        right: width * 0.065,
                        bottom: height * 0.02,
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: width * 0.033,
                          right: width * 0.025,
                          top: height * 0.025,
                          bottom: height * 0.025,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                darktheme
                                    ? WhiteTextRegularNunita(
                                    title: data['title'],
                                    weight: FontWeight.w500,
                                    size: width * 0.032)
                                    : BlackTextRegularNunita(
                                    title: data['title'],
                                    weight: FontWeight.w500,
                                    size: width * 0.032),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                darktheme
                                    ? Container(
                                  width: width * 0.3,
                                  child: WhiteTextBold(
                                    title: data['description'],
                                    weight: FontWeight.w700,
                                    size: width * 0.032,
                                  ),
                                )
                                    : Container(
                                  width: width * 0.3,
                                  child: BlackTextRegularNunita(
                                    title: data['description'],
                                    weight: FontWeight.w700,
                                    size: width * 0.032,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                darktheme
                                    ? WhiteTextRegularNunita(
                                    title: "\$" +
                                        data['price'].toString(),
                                    weight: FontWeight.w500,
                                    size: width * 0.032)
                                    : BlackTextRegularNunita(
                                    title: "\$" +
                                        data['price'].toString(),
                                    weight: FontWeight.w500,
                                    size: width * 0.032),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: width * 0.025,
                                  right: width * 0.025),
                              child: Image.network(
                                data['images'][0],
                                width: width * 0.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
          SizedBox(
            height: height * 0.025,
          ),
        ]),
      ),
    );
  }
}
