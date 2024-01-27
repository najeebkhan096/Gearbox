import 'package:flutter/material.dart';
import 'package:gearbox/Widgets/constant.dart';


class BlackTextRegular extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;
  bool ? center;

  BlackTextRegular({
    required
    this.title,
    required
    this.weight,
    required
    this.size,
    this.center

  });

  @override
  Widget build(BuildContext context) {
    return Text(

      title!,
      style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          fontFamily: 'Poppins-Regular',
          color: const Color(0xff3C3C3C),
      ),
      textAlign:
      center==true?
      TextAlign.center:TextAlign.start,

    );
  }
}

class BlackTextRegularNunita extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;
  bool ? center;

  BlackTextRegularNunita({
    required
    this.title,
    required
    this.weight,
    required
    this.size,
    this.center

  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Nunito-Regular',
        color: Color(0xff3C3C3C),
      ),
      textAlign:
      center==true?
      TextAlign.center:TextAlign.start,

    );
  }
}

class WhiteTextRegularNunita extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;
  bool ? center;

  WhiteTextRegularNunita({
    required
    this.title,
    required
    this.weight,
    required
    this.size,
    this.center

  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Nunito-Regular',
        color: Colors.white,
      ),
      textAlign:
      center==true?
      TextAlign.center:TextAlign.start,

    );
  }
}
class BlueTextRegularNunita extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;
  bool ? center;

  BlueTextRegularNunita({
    required
    this.title,
    required
    this.weight,
    required
    this.size,
    this.center

  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Nunito-Regular',
        color: blue,
      ),
      textAlign:
      center==true?
      TextAlign.center:TextAlign.start,

    );
  }
}
class BlueBlackTextRegular extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;
  bool ? center;

  BlueBlackTextRegular({
    required
    this.title,
    required
    this.weight,
    required
    this.size,
    this.center

  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Poppins-Regular',
        color: Color(0xff535865),
      ),
      textAlign:
      center==true?
      TextAlign.center:TextAlign.start,

    );
  }
}

class BlackTextBold extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;
  bool ? center;

  BlackTextBold({
    required
    this.title,
    required
    this.weight,
    required
    this.size,
    this.center

  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Poppins-Bold',
        color: Color(0xff3C3C3C),
      ),
      textAlign:
      center==true?
      TextAlign.center:TextAlign.start,

    );
  }
}
class WhiteTextBold extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;
  bool ? center;

  WhiteTextBold({
    required
    this.title,
    required
    this.weight,
    required
    this.size,
    this.center

  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Poppins-Bold',
        color: Colors.white,
      ),
      textAlign:
      center==true?
      TextAlign.center:TextAlign.start,

    );
  }
}
class LightBlueTextRegular extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;
  bool ? center;

  LightBlueTextRegular({
    required
    this.title,
    required
    this.weight,
    required
    this.size,
    this.center

  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Poppins-Regular',
        color: Color(0xff0078FF),
      ),
      textAlign:
      center==true?
      TextAlign.center:TextAlign.start,

    );
  }
}


class GreyTextRegular extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;
  bool ? center;

  GreyTextRegular({
    required
    this.title,
    required
    this.weight,
    required
    this.size,
    this.center

  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Poppins-Light',
        color: Color(0xff756F6F),
      ),
      textAlign:
      center==true?
      TextAlign.center:TextAlign.start,

    );
  }
}
class DarkBlackTextRegular extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;
  bool ? center;

  DarkBlackTextRegular({
    required
    this.title,
    required
    this.weight,
    required
    this.size,
    this.center

  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: 'Poppins-Bold',
        color: Colors.black,
      ),
      textAlign:
      center==true?
      TextAlign.center:TextAlign.start,

    );
  }
}

class WhiteTextRegular extends StatelessWidget {
String ? title;
double ? size;
FontWeight ? weight;

WhiteTextRegular({
   required
  this.title,
  required
  this.weight,
  required
  this.size});

@override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          fontFamily: 'Poppins-Regular',
          color: Color(0xffFFFFFF)
      ),

    );
  }
}

// class LightBlueTextRegular extends StatelessWidget {
//   String ? title;
//   double ? size;
//   FontWeight ? weight;
//
//   LightBlueTextRegular({
//     required
//     this.title,
//     required
//     this.weight,
//     required
//     this.size});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(title!,
//       style: TextStyle(
//           fontSize: size,
//           fontWeight: weight,
//           fontFamily: 'Poppins-Regular',
//           color: Color(0xff525666)
//       ),
//
//     );
//   }
// }


class DarkTextRegular extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;

  DarkTextRegular({
    required
    this.title,
    required
    this.weight,
    required
    this.size});

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          fontFamily: 'Poppins-Regular',
          color: darkblue
      ),

    );
  }
}
class BlueTextRegular extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;

  BlueTextRegular({
    required
    this.title,
    required
    this.weight,
    required
    this.size});

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          fontFamily: 'Poppins-Regular',
          color: blue
      ),

    );
  }
}
class RedTextRegular extends StatelessWidget {
  String ? title;
  double ? size;
  FontWeight ? weight;

  RedTextRegular({
    required
    this.title,
    required
    this.weight,
    required
    this.size});

  @override
  Widget build(BuildContext context) {
    return Text(title!,
      style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          fontFamily: 'Poppins-Regular',
          color: Color(0xffED1C24)
      ),

    );
  }
}
