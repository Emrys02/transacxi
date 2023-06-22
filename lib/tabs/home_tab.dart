import 'package:flutter/material.dart';

import '../constants/managers/asset_manager.dart';
import '../constants/managers/spacing_manager.dart';
import '../constants/managers/string_manager.dart';
import '../controllers/user_controller.dart';
import '../handlers/navigation_screen_handler.dart';
import '../widgets/dashboard_options.dart';
import '../widgets/transaction_list_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _viewHanlder = NavigationViewStateHandler();
  final _userController = UserController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpacingManager.h40,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SpacingManager.w10.width!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(AssetManager.logoMini),
              CircleAvatar(
                radius: SpacingManager.w25.width,
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
            Image.asset(AssetManager.balanceBackground),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpacingManager.h55,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: SpacingManager.w30.width!, vertical: SpacingManager.h5.height!),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF888888)))),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [const Text(StringManager.naira), SpacingManager.w10, Text(_userController.currentUser.balance.toString())]),
                ),
                SpacingManager.h18,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DasboardOptions(label: StringManager.addMoney, icon: Icons.account_balance_wallet_outlined, function: () {}),
                    SpacingManager.w20,
                    DasboardOptions(
                        label: StringManager.transactionHistory,
                        icon: Icons.schedule,
                        function: () {
                          _viewHanlder.changeCurrentView(3);
                        }),
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
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFb9b6b6)))),
          child: const Text(StringManager.recent),
        ),
        SpacingManager.h5,
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: SpacingManager.w10.width!),
                  padding: EdgeInsets.only(
                      top: SpacingManager.h10.height!, bottom: SpacingManager.h10.height!, left: SpacingManager.w10.width!, right: SpacingManager.w15.width!),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFb9b6b6), width: 0))),
                  child: const Text("date"),
                ),
                SpacingManager.h10,
                ...List.generate(2, (index) => const TransactionListTile())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
