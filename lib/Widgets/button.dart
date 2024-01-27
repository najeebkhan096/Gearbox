import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gearbox/Widgets/constant.dart';
import 'package:gearbox/Widgets/text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class DarkBlueButton extends StatelessWidget {
final String ? title;
 VoidCallback ? onprrss;
DarkBlueButton({required this.title,this.onprrss});
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onprrss,
      child: Container(
        margin: EdgeInsets.only(left: width*0.05,
        right: width*0.05
        ),
        width: width*1,
        height: height*0.057,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: darkblue
        ),
        child: Center(child: WhiteTextRegular(title: title!, weight: FontWeight.w700, size: width*0.035)),
      ),
    );
  }
}
class LightBlueButton extends StatelessWidget {
  final String ? title;
  VoidCallback ? onprrss;
  LightBlueButton({required this.title,this.onprrss});
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onprrss,
      child: Container(
        margin: EdgeInsets.only(left: width*0.05,
            right: width*0.05
        ),
        width: width*1,
        height: height*0.057,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xffD4E2F2)
        ),
        child: Center(child: BlackTextRegular(title: title!, weight: FontWeight.w700, size: width*0.035)),
      ),
    );
  }
}

class RoundDarkBlueButton extends StatelessWidget {
  final String ? title;
  VoidCallback ? onpress;
  RoundDarkBlueButton({required this.title,required this.onpress});
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.only(left: width*0.05,
            right: width*0.05
        ),
        width: width*1,
        height: height*0.05,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: darkblue
        ),
        child: Center(child: WhiteTextRegular(title: title!, weight: FontWeight.w700, size: width*0.035)),
      ),
    );
  }
}

class WhiteButton extends StatelessWidget {
  final String ? title;
  VoidCallback ? onpress;
  WhiteButton({required this.title,this.onpress});
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.only(left: width*0.05,
            right: width*0.05
        ),
        width: width*1,
        height: height*0.065,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child: Center(child: DarkTextRegular(title: title!, weight: FontWeight.w600, size: width*0.035)),
      ),
    );
  }
}


class CustomTextfield extends StatelessWidget {
  final String ? hint;
  ValueChanged ? onchange;
  CustomTextfield({super.key, required this.hint,required this.onchange});

  @override
  Widget build(BuildContext context) {

    final width=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: width*0.05,
          right: width*0.05
      ),
      width: width*1,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        border: Border.all(
          color: Colors.black
        )
      ),
child: TextField(
  onChanged: onchange,
  style:TextStyle(
    fontSize:
    kIsWeb?16:
    width*0.03,
    fontWeight: FontWeight.w700,
    fontFamily: 'Poppins-Regular',
    color: Color(0xff3C3C3C),
  ),
  decoration: InputDecoration(
    contentPadding: EdgeInsets.only(left: width*0.025),
    border: InputBorder.none,
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: width*0.03,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins-Regular',

    ),
  )
),
    );
  }
}
class LightCustomTextfield extends StatelessWidget {
  final String ? hint;
  ValueChanged ? onchange;
  final bool ? underlineBorder;
  LightCustomTextfield({required this.hint,this.underlineBorder});
  @override
  Widget build(BuildContext context) {

    final width=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: width*0.05,
          right: width*0.05
      ),
      width: width*1,

      child: TextField(
          onChanged: onchange,
          style:TextStyle(
            fontSize: width*0.03,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins-Regular',
            color: Color(0xff3C3C3C),
          ),

          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: width*0.025),
            border:
            underlineBorder==true?
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffE4E8F2),

              ),
            )
                :
            OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xffE4E8F2),
              ),
              borderRadius: BorderRadius.circular(10)
            ),

            hintText: hint,
            hintStyle: TextStyle(
              fontSize: width*0.03,
              color: darktheme?Color(0xff303F4F):Color(0xffC0CCD9),
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins-Regular',

            ),
          )
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String? hint;
  final ValueChanged<String?>? onChanged;
  final List<Map<String,dynamic>> dropdownItems;
  String? selectedValue;

  CustomDropdown({
    required this.hint,
    required this.dropdownItems,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
      ),
      width: width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: onChanged,
        items: dropdownItems.map((Map item) {
          return DropdownMenuItem<String>(
            value: item['Manufacturer'],
            child: Text(
              item['Manufacturer'],
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
                color: Color(0xff3C3C3C),
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: width * 0.025,right: width*0.05),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: width * 0.03,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins-Regular',
          ),
        ),
      ),
    );
  }
}

class CustomDropdownString extends StatelessWidget {
  final String? hint;
  final ValueChanged<String?>? onChanged;
  final List<String> dropdownItems;
  String? selectedValue;

  CustomDropdownString({
    required this.hint,
    required this.dropdownItems,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
      ),
      width: width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: onChanged,
        items: dropdownItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
                color: Color(0xff3C3C3C),
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: width * 0.025,right: width*0.025),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: width * 0.03,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins-Regular',
          ),
        ),
      ),
    );
  }
}

class LightPinkDropdown extends StatelessWidget {
  final String? hint;
  final ValueChanged<String?>? onChanged;
  final List<Map<String,dynamic>> dropdownItems;
  String? selectedValue;

  LightPinkDropdown({
    required this.hint,
    required this.dropdownItems,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        left: width * 0.03,
        right: width * 0.025,
      ),
      width: width * 1,
      height: height*0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffF9FAFE),
        border: Border.all(
          color: Colors.grey,
        ),

      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: onChanged,
        icon: Icon(Icons.keyboard_arrow_down_sharp,color: Color(0xffAFAFAF),size: height*0.035,),
        items: dropdownItems.map((Map item) {
          return DropdownMenuItem<String>(
            value: item["Manufacturer"],
            child: Text(
              item["Manufacturer"],
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
                color: Color(0xff3C3C3C),
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: width * 0.01,
          right: width*.015
          ),

          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
color: Color(0xffAFAFAF),
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins-Regular',
          ),


        ),
      ),
    );
  }
}
class LightPinkDropdownString extends StatelessWidget {
  final String? hint;
  final ValueChanged<String?>? onChanged;
  final List<String> dropdownItems;
  String? selectedValue;

  LightPinkDropdownString({
    required this.hint,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedValue
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        left: width * 0.03,
        right: width * 0.025,
      ),
      width: width * 1,
      height: height*0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffF9FAFE),
        border: Border.all(
          color: Colors.grey,
        ),

      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: onChanged,
        icon: Icon(Icons.keyboard_arrow_down_sharp,color: Color(0xffAFAFAF),size: height*0.035,),
        items: dropdownItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
                color: Color(0xff3C3C3C),
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: width * 0.01,
              right: width*.015
          ),

          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Color(0xffAFAFAF),
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins-Regular',
          ),


        ),
      ),
    );
  }
}
class LightBorderCustomDropdown extends StatelessWidget {
  final String? hint;
  final ValueChanged<String?>? onChanged;
  final List<Map<String,dynamic>> dropdownItems;
  String? selectedValue;

  LightBorderCustomDropdown({
    required this.hint,
    required this.dropdownItems,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(right: width*0.025),
      margin: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
      ),
      width: width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color:    darktheme?bgcolor:Colors.white,
        border: Border.all(
          color:
          darktheme?
              Colors.white24
              :
          Colors.black12,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: onChanged,
        items: dropdownItems.map((Map item) {
          return DropdownMenuItem<String>(
            value: item["Manufacturer"],
            child: Text(
              item["Manufacturer"],
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
                color:
                darktheme?
                    Colors.white
                    :
                Color(0xff3C3C3C),
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: width * 0.025),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: width * 0.03,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins-Regular',
            color: darktheme?
            Colors.white
                :
            Color(0xff3C3C3C),
          ),
        ),
      ),
    );
  }
}
class LightBorderCustomDropdownString extends StatelessWidget {
  final String? hint;
  final ValueChanged<String?>? onChanged;
  final List<String> dropdownItems;
  String? selectedValue;

  LightBorderCustomDropdownString({
    required this.hint,
    required this.dropdownItems,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {


    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(right: width*0.025),
      margin: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
      ),
      width: width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color:    darktheme?bgcolor:Colors.white,
        border: Border.all(
          color:
          darktheme?
          Colors.white24
              :
          Colors.black12,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: onChanged,
        items: dropdownItems.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins-Regular',
                color:
                darktheme?
                Colors.white
                    :
                Color(0xff3C3C3C),
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: width * 0.025),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: width * 0.03,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins-Regular',
            color: darktheme?
            Colors.white
                :
            Color(0xff3C3C3C),
          ),
        ),
      ),
    );
  }
}