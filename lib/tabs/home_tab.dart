import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/managers/asset_manager.dart';
import '../constants/managers/spacing_manager.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpacingManager.h40,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SpacingManager.w10.width!),
          child: Row(
            children: [
              SvgPicture.asset(AssetManager.logoMini),
              CircleAvatar(
                radius: SpacingManager.w50.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SpacingManager.w50.width!),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
