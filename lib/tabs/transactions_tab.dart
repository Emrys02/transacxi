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
            children: [
              CircleAvatar(
                radius: SpacingManager.w15.width!,
                backgroundColor: const Color(0x80B9B6B6),
                child: const Icon(CupertinoIcons.arrow_up_right_circle_fill),
              ),
              CircleAvatar(
                radius: SpacingManager.w50.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SpacingManager.w50.width!),
                ),
              ),
            ],
          ),
        ),
        SpacingManager.h10,
        ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
