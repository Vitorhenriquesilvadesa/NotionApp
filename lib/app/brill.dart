import 'package:brill_app/app/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrillApp extends StatelessWidget {
  const BrillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}
