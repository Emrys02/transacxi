import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
              if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.primary,
                    highlightColor: Theme.of(context).colorScheme.onPrimary,
                    child: const TransactionListTile(),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return const Center(child: Text(StringManager.allTransactionHere));
              }
              return ListView.builder(
                itemCount: snapshot.data?.size ?? 0,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.width()),
                      padding: EdgeInsets.only(top: 10.height(), bottom: 10.height(), left: 10.width(), right: 15.width()),
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFB9B6B6), width: 0))),
                      child: Text("${snapshot.data?.docs[index].id}"),
                    ),
                    SizedBox(height: 10.height()),
                    ...List.generate(
                      snapshot.data?.docs[index].data().length ?? 0,
                      (index2) => TransactionListTile(
                          transaction: Transaction.fromJson({
                        snapshot.data?.docs[index].data().entries.elementAt(index2).key ?? "": snapshot.data?.docs[index].data().entries.elementAt(index2).value
                      })),
                    ),
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
