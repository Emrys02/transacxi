import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';

import '../constants/managers/string_manager.dart';
import '../controllers/user_controller.dart';
import '../extensions/num_extension.dart';
import '../models/transaction.dart';
import '../providers/transactions_provider.dart';
import '../widgets/elements/transaction_list_tile.dart';

class TransactionsTab extends StatefulWidget {
  const TransactionsTab({super.key});

  @override
  State<TransactionsTab> createState() => _TransactionsTabState();
}

class _TransactionsTabState extends State<TransactionsTab> {
  final _userController = UserController();

  Widget get _image {
    if (_userController.currentUser.profileImage.isNotEmpty) return Image.network(_userController.currentUser.profileImage, fit: BoxFit.cover);
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.height()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.width()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 15.width(),
                backgroundColor: const Color(0x80B9B6B6),
                child: const Icon(CupertinoIcons.arrow_up_right_circle_fill),
              ),
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
        SizedBox(height: 10.height()),
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
                        if (!temp.contains(Transaction.fromJson({data.key: data.value}))) temp.add(Transaction.fromJson({data.key: data.value}));
                      }
                      return temp;
                    });
                  } else {
                    _userController.currentUser.transactions.putIfAbsent(element.id, () {
                      final temp = <Transaction>[];
                      for (var data in element.data().entries) {
                        if (!temp.contains(Transaction.fromJson({data.key: data.value}))) temp.add(Transaction.fromJson({data.key: data.value}));
                      }
                      return temp;
                    });
                  }
                }
              }
              if (_userController.currentUser.transactions.isEmpty) {
                return const Center(child: Text(StringManager.allTransactionHere));
              }
              return ListView.builder(
                itemCount: _userController.currentUser.transactions.length,
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
