import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('ar', 'DZ');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    print("locale is "+newLocale.languageCode.toString());

      _locale = newLocale;
      notifyListeners();
      print("barwa " +_locale.languageCode.toString());

  }
}
