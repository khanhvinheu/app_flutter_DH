import 'package:flutter/material.dart';

extension LocaleEquality on Locale {
  bool equals(Locale other) {
    return languageCode == other.languageCode &&
           countryCode == other.countryCode;
  }
}
