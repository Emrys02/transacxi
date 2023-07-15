import 'package:flutter/material.dart';

import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../constants/screen_size.dart';
import '../../extensions/num_extension.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width,
      padding: EdgeInsets.only(
        top: 15.height(),
        bottom: 5.height(),
        left: 10.width(),
        right: 10.width(),
      ),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFb9b6b6), width: 0))),
      child: Row(
        children: [
          Image.asset(AssetManager.transactionIcon),
          SizedBox(height: 30.width()),
          const Text("receiver"),
          const Expanded(child: Text("-${StringManager.naira}amount", textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
