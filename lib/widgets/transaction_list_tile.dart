import 'package:flutter/material.dart';

import '../constants/managers/asset_manager.dart';
import '../constants/managers/spacing_manager.dart';
import '../constants/managers/string_manager.dart';
import '../constants/screen_size.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width,
      padding: EdgeInsets.only(
        top: SpacingManager.h15.height!,
        bottom: SpacingManager.h5.height!,
        left: SpacingManager.w10.width!,
        right: SpacingManager.w10.width!,
      ),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFb9b6b6), width: 0))),
      child: Row(
        children: [
          Image.asset(AssetManager.transactionIcon),
          SpacingManager.w30,
          const Text("receiver"),
          const Expanded(child: Text("-${StringManager.naira}amount", textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
