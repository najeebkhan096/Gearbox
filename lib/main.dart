import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gearbox/Admin/dashboard.dart';
import 'package:gearbox/Admin/login.dart';
import 'package:gearbox/Auth/auth.dart';
import 'package:gearbox/Screens/home.dart';
import 'package:gearbox/Screens/workshopDetails.dart';
import 'package:gearbox/Widgets/provider.dart';
import 'package:gearbox/Widgets/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        storageBucket: "gearbox-e5eac.appspot.com",
          apiKey: "AIzaSyDgWB2cVkltLw6phV7FTTylHJKjQRFg7No",
          appId: "1:1085713499323:android:e34d8abee98c88d37f959e",
          messagingSenderId: "1085713499323",
          projectId: "gearbox-e5eac")

    );
  } else {

    await Firebase.initializeApp(
      options: FirebaseOptions(
        storageBucket: "gearbox-e5eac.appspot.com",
        apiKey: "AIzaSyApnhrulne3KHGhuiQyIgmwbEYv2XUAVFc",
        projectId: "gearbox-e5eac",
        messagingSenderId: "1085713499323",
        appId: "1:1085713499323:web:05605229b98645ec7f959e",
      ),
    );
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
      path: "resource/langs",
      saveLocale: true,
      startLocale: Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),

      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: (!kIsWeb) ? Wrapper() : AdminLoginScreen(),
            routes: {
              "HomeScreen": (context) => HomeScreen(),
              "DashboardScreen": (context) => DashboardScreen(),
              "WorkshopsDetailScreen": (context) => WorkshopsDetailScreen(),
              "Wrapper": (context) => Wrapper(),
            },

            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

          );
        }
        ),
    );
  }
}

