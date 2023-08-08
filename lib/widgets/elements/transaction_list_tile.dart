import 'package:flutter/material.dart';

import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../constants/screen_size.dart';
import '../../controllers/user_controller.dart';
import '../../extensions/num_extension.dart';
import '../../models/transaction.dart';
import '../../models/user.dart';

class TransactionListTile extends StatefulWidget {
  const TransactionListTile({Transaction? transaction, super.key}) : _transaction = transaction;
  final Transaction? _transaction;

  @override
  State<TransactionListTile> createState() => _TransactionListTileState();
}

class _TransactionListTileState extends State<TransactionListTile> {
  final User _user = UserController().currentUser;

  Color get _amountColor {
    if (widget._transaction?.type == TransactionType.credit) return Colors.green;
    return Colors.red;
  }

  String get _amountSymbol {
    if (widget._transaction?.type == TransactionType.credit) return "+";
    return "-";
  }

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
          Text(widget._transaction?.receiver ?? _user.fullname),
          Expanded(
            child:
                Text("$_amountSymbol${StringManager.naira}${widget._transaction?.amount}", textAlign: TextAlign.right, style: TextStyle(color: _amountColor)),
          ),
        ],
      ),
    );
  }
}
