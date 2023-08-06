import 'package:flutter/material.dart';

import '../constants/managers/asset_manager.dart';
import '../constants/managers/string_manager.dart';
import '../controllers/user_controller.dart';
import '../extensions/num_extension.dart';
import '../handlers/navigation_screen_handler.dart';
import '../services/bottom_sheet_service.dart';
import '../widgets/elements/dashboard_options.dart';
import '../widgets/elements/transaction_list_tile.dart';
import '../widgets/elements/underlined_container.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _viewHanlder = NavigationViewStateHandler();
  final _userController = UserController();

  Widget get _image {
    if (_userController.currentUser.profileImage.isNotEmpty) return Image.network(_userController.currentUser.profileImage, fit: BoxFit.cover);
    return const SizedBox.shrink();
  }

  void _showFundWalletBottomSheet() async {
    await BottomSheetService.showFundingSheet();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.height()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.width()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(AssetManager.logoMini),
              GestureDetector(
                onTap: Scaffold.of(context).openEndDrawer,
                child: SizedBox.square(
                  dimension: 50.width(),
                  child: ClipRRect(borderRadius: BorderRadius.circular(25.width()), child: _image),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 67.height()),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AssetManager.balanceBackground),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 55.height()),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.width(), vertical: 5.height()),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF888888)))),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [const Text(StringManager.naira), SizedBox(width: 10.width()), Text(_userController.currentUser.balance.toString())]),
                ),
                SizedBox(height: 18.height()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DashboardOptions(label: StringManager.addMoney, icon: Icons.account_balance_wallet_outlined, function: _showFundWalletBottomSheet),
                    SizedBox(width: 20.width()),
                    DashboardOptions(label: StringManager.transactionHistory, icon: Icons.schedule, function: () => _viewHanlder.changeCurrentView(3)),
                    SizedBox(width: 20.width()),
                    DashboardOptions(label: StringManager.transfer, icon: Icons.swap_horiz_rounded, function: () {}),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(width: 30.width()),
        const UnderlinedContainer(text: StringManager.recent),
        SizedBox(height: 5.height()),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.width()),
                  padding: EdgeInsets.only(top: 10.height(), bottom: 10.height(), left: 10.width(), right: 15.width()),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFb9b6b6), width: 0))),
                  child: const Text("date"),
                ),
                SizedBox(height: 10.height()),
                ...List.generate(2, (index) => const TransactionListTile())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
