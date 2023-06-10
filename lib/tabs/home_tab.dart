import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/managers/asset_manager.dart';
import '../constants/managers/spacing_manager.dart';
import '../constants/managers/string_manager.dart';
import '../constants/screen_size.dart';
import '../widgets/dashboard_options.dart';
import '../widgets/transaction_list_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
        SpacingManager.h67,
        Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(AssetManager.balanceBackground),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpacingManager.h55,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: SpacingManager.w30.width!, vertical: SpacingManager.h5.height!),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF888888)))),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [const Text(StringManager.naira), SpacingManager.w10, const Text("balance")]),
                ),
                SpacingManager.h18,
                Row(
                  children: [
                    DasboardOptions(label: StringManager.addMoney, icon: Icons.account_balance_wallet_outlined, function: () {}),
                    SpacingManager.w20,
                    DasboardOptions(label: StringManager.transactionHistory, icon: Icons.schedule, function: () {}),
                    SpacingManager.w20,
                    DasboardOptions(label: StringManager.transfer, icon: Icons.swap_horiz_rounded, function: () {}),
                  ],
                ),
              ],
            ),
          ],
        ),
        SpacingManager.w30,
        Container(
          padding: EdgeInsets.only(
              top: SpacingManager.h10.height!, bottom: SpacingManager.h10.height!, left: SpacingManager.w10.width!, right: SpacingManager.w20.width!),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0x00b9b6b6)))),
          child: const Text(StringManager.recent),
        ),
        SpacingManager.h5,
        ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: SpacingManager.h10.height!, bottom: SpacingManager.h10.height!, left: SpacingManager.w10.width!, right: SpacingManager.w15.width!),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0x00b9b6b6)))),
                child: const Text("date"),
              ),
              SpacingManager.h10,
              ...List.generate(5, (index) => const TransactionListTile())
            ],
          ),
        ),
      ],
    );
  }
}