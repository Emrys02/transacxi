import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';

import '../constants/managers/spacing_manager.dart';
import '../widgets/transaction_list_tile.dart';

class TransactionsTab extends StatefulWidget {
  const TransactionsTab({super.key});

  @override
  State<TransactionsTab> createState() => _TransactionsTabState();
}

class _TransactionsTabState extends State<TransactionsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpacingManager.h30,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SpacingManager.w10.width!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: SpacingManager.w15.width!,
                backgroundColor: const Color(0x80B9B6B6),
                child: const Icon(CupertinoIcons.arrow_up_right_circle_fill),
              ),
              CircleAvatar(
                radius: SpacingManager.w25.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SpacingManager.w50.width!),
                ),
              ),
            ],
          ),
        ),
        SpacingManager.h10,
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: SpacingManager.w10.width!),
                  padding: EdgeInsets.only(
                      top: SpacingManager.h10.height!, bottom: SpacingManager.h10.height!, left: SpacingManager.w10.width!, right: SpacingManager.w15.width!),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFB9B6B6), width: 0))),
                  child: const Text("date"),
                ),
                SpacingManager.h10,
                ...List.generate(5, (index) => const TransactionListTile())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
