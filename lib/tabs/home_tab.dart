import 'package:flutter/material.dart';

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
            children: [],
          ),
        )
      ],
    );
  }
}
