import 'package:flutter/material.dart';

class MyAppBar {
  static getAppBar(String title, bool hasArrowBack) {
    return AppBar(
      automaticallyImplyLeading: hasArrowBack,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      ),
    );
  }
}