import 'dart:math' show min;

import 'package:flutter/material.dart';

import '../constants/managers/asset_manager.dart';
import '../constants/managers/string_manager.dart';
import '../controllers/user_controller.dart';
import '../extensions/num_extension.dart';
import '../handlers/navigation_screen_handler.dart';
import '../models/transaction.dart';
import '../providers/transactions_provider.dart';
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

  void _showTransferBottomSheet() {
    BottomSheetService.showTransferDestinationSheet();
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
                      children: [const Text(StringManager.naira), SizedBox(width: 10.width()), Text(_userController.currentUser.balance.toStringAsFixed(2))]),
                ),
                SizedBox(height: 18.height()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DashboardOptions(label: StringManager.addMoney, icon: Icons.account_balance_wallet_outlined, function: _showFundWalletBottomSheet),
                    SizedBox(width: 20.width()),
                    DashboardOptions(label: StringManager.transactionHistory, icon: Icons.schedule, function: () => _viewHanlder.changeCurrentView(3)),
                    SizedBox(width: 20.width()),
                    DashboardOptions(label: StringManager.transfer, icon: Icons.swap_horiz_rounded, function: _showTransferBottomSheet),
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
          child: StreamBuilder(
            stream: TransactionProvider.transactions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (var element in snapshot.data!.docs) {
                  if (_userController.currentUser.transactions.containsKey(element.id)) {
                    _userController.currentUser.transactions.update(element.id, (value) {
                      final temp = value;
                      for (var data in element.data().entries) {
                        temp.add(Transaction.fromJson({data.key: data.value}));
                      }
                      return temp;
                    });
                  } else {
                    _userController.currentUser.transactions.putIfAbsent(element.id, () {
                      final temp = <Transaction>[];
                      for (var data in element.data().entries) {
                        temp.add(Transaction.fromJson({data.key: data.value}));
                      }
                      return temp;
                    });
                  }
                }
              }
              if (_userController.currentUser.transactions.isEmpty) {
                return const Center(child: Text(StringManager.recentTransactionHere));
              }
              return ListView.builder(
                itemCount: min(3, _userController.currentUser.transactions.length),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.width()),
                      padding: EdgeInsets.only(top: 10.height(), bottom: 10.height(), left: 10.width(), right: 15.width()),
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFb9b6b6), width: 0))),
                      child: Text(_userController.currentUser.transactions.keys.elementAt(index)),
                    ),
                    SizedBox(height: 10.height()),
                    ...List.generate(
                      _userController.currentUser.transactions[_userController.currentUser.transactions.keys.elementAt(index)]?.length ?? 0,
                      (index2) => TransactionListTile(
                          transaction: _userController.currentUser.transactions[_userController.currentUser.transactions.keys.elementAt(index)]![index2]),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
