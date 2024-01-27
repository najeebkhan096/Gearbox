//
// import 'package:flutter/material.dart';
// import 'package:gearbox/Widgets/constant.dart';
// import 'package:gearbox/Widgets/text.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class PaymentWebView extends StatefulWidget {
//   static const routename="PaymentWebView";
//
//   @override
//   State<PaymentWebView> createState() => _PaymentWebViewState();
// }
//
// class _PaymentWebViewState extends State<PaymentWebView> {
//   String ? url;
//   @override
//   Widget build(BuildContext context) {
//     final height=MediaQuery.of(context).size.height;
//     final width=MediaQuery.of(context).size.width;
//     url=ModalRoute.of(context)!.settings.arguments as String;
//     return  SafeArea(
//       child: Scaffold(
//         backgroundColor: darktheme?bgcolor:const Color(0xffFFFFFF),
//
//         body: WebView(
//           onPageFinished: (value){
//             print("onPageFinished value is "+value.toString());
//
//           },
//           onPageStarted: (value){
//
//           },
//           onWebViewCreated: (value){
//             print("onWebViewCreated value is "+value.toString());
//           },
//           onProgress: (value){
//             print("onProgress value is "+value.toString());
//           },
//           javascriptMode: JavascriptMode.unrestricted,
//           initialUrl: url,
//         ),
//       ),
//     );
//   }
// }
