import 'package:flutter/material.dart';

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ).merge(ButtonStyle(
    elevation: MaterialStateProperty.resolveWith<double>(
      (Set<MaterialState> states) {
        return 2.0;
      },
    ),
  )),
);
