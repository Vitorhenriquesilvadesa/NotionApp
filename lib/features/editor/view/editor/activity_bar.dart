import 'package:brill_app/core/metrics/sizes.dart';
import 'package:brill_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ActivityBar extends StatelessWidget {
  const ActivityBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: AppSizes.leftMenuWidth,
      child: Container(color: AppColorsDark.menuBackground),
    );
  }
}
