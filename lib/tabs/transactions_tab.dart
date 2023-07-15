import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';

import '../extensions/num_extension.dart';
import '../widgets/elements/transaction_list_tile.dart';

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
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: CircleAvatar(
                  radius: 25.width(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.width()),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.height()),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.width()),
                  padding: EdgeInsets.only(top: 10.height(), bottom: 10.height(), left: 10.width(), right: 15.width()),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFB9B6B6), width: 0))),
                  child: const Text("date"),
                ),
                SizedBox(height: 10.height()),
                ...List.generate(5, (index) => const TransactionListTile())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
