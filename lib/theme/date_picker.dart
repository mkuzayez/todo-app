import 'package:flutter/material.dart';

const DatePickerThemeData customDatePickerTheme = DatePickerThemeData(
  backgroundColor: Color.fromARGB(255, 255, 255, 255),
  dayForegroundColor: WidgetStatePropertyAll(Colors.black),
  todayForegroundColor: WidgetStatePropertyAll(Colors.black),
  todayBorder: BorderSide.none,
  shape: ContinuousRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        24,
      ),
    ),
  ),
  yearForegroundColor: WidgetStatePropertyAll(Colors.black),
  shadowColor: Colors.black,
  elevation: 8,
  weekdayStyle: TextStyle(
    color: Color(0xFFF79E89),
  ),
  yearStyle: TextStyle(color: Colors.white),
  dayStyle: TextStyle(color: Colors.white),
  headerBackgroundColor: Colors.blueGrey,
  headerForegroundColor: Colors.white,
);
