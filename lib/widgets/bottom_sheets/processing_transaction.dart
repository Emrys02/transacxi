import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:transacxi/controllers/transaction_controller.dart';
import 'package:transacxi/extensions/num_extension.dart';

import '../../constants/managers/asset_manager.dart';
import '../../controllers/user_controller.dart';
import '../../providers/transactions_provider.dart';

class ProcessingTransaction extends StatefulWidget {
  const ProcessingTransaction({super.key});

  @override
  State<ProcessingTransaction> createState() => _ProcessingTransactionState();
}

class _ProcessingTransactionState extends State<ProcessingTransaction> {
  final _transactionController = TransactionController();
  final _userController = UserController();

  Future<void> _transferFunds() async {
    _breakUpFunds();
    log("flutterwaveAmount: ${_transactionController.flutterwaveAmount}");
    log("paystackAmount: ${_transactionController.paystackAmount}");
    // return;
    if (_transactionController.flutterwaveCode.isEmpty && _transactionController.paystackCode.isEmpty) {
      await TransactionProvider.creditReceiver();
      await TransactionProvider.saveTransactionForReceiver();
      await TransactionProvider.debitUser();
      log("completed");
    } else {
      Navigator.of(context).pop();
    }
  }

  void _breakUpFunds() {
    if (_transactionController.amount > _userController.currentUser.flutterwaveBalance) {
      _transactionController.flutterwaveAmount = _userController.currentUser.flutterwaveBalance;
    } else if (_userController.currentUser.flutterwaveBalance >= _transactionController.amount) {
      _transactionController.flutterwaveAmount = _transactionController.amount;
    }
    _transactionController.paystackAmount = _transactionController.amount - _transactionController.flutterwaveAmount;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: FutureBuilder(
        future: _transferFunds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(height: 300.height(), child: const Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasError) {
            return Column(
              children: [
                Image.asset(AssetManager.error),
                SizedBox(height: 20.height()),
                Text(snapshot.error.toString()),
                SizedBox(height: 20.height()),
              ],
            );
          }
          Future.delayed(const Duration(seconds: 3), () => Navigator.of(context).pop());
          return Image.asset(AssetManager.success);
        },
      ),
    );
  }

  @override
  void dispose() {
    _transactionController.dispose();
    super.dispose();
  }
}
