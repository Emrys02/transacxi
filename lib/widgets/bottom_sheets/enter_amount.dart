import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:transacxi/constants/constants.dart';

import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../controllers/transaction_controller.dart';
import '../../controllers/user_controller.dart';
import '../../extensions/num_extension.dart';
import '../../models/transaction.dart';
import '../../providers/transactions_provider.dart';
import '../elements/button_with_loading_indicator.dart';
import '../elements/underlined_container.dart';

class EnterAmount extends StatefulWidget {
  const EnterAmount({super.key});

  @override
  State<EnterAmount> createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  final _transactionController = TransactionController();
  final _userController = UserController();
  Future<void> _makePayment() async {
    if (_transactionController.amount == 0) return;
    _transactionController.updateTxRef = DateTime.now().toIso8601String();
    if (_transactionController.provider == Provider.flutterwave) {
      final ref = await Flutterwave(
        context: context,
        publicKey: kFlutterwavePublicKey,
        txRef: _transactionController.txRef,
        amount: _transactionController.amount.toString(),
        customer: Customer(email: _userController.currentUser.email, name: _userController.currentUser.fullname),
        paymentOptions: "card",
        customization: Customization(title: StringManager.transacxi, description: StringManager.fundWallet, logo: AssetManager.logoMedium),
        redirectUrl: "/",
        isTestMode: true,
        currency: _transactionController.currency,
      ).charge();
      _transactionController.updateTxId = ref.transactionId.toString();
      log(ref.status.toString());
    } else if (_transactionController.provider == Provider.paystack) {
      final ref = await PayWithPayStack().now(
        context: context,
        secretKey: kPaystackSecretKey,
        customerEmail: _userController.currentUser.email,
        reference: _transactionController.txRef,
        currency: _transactionController.currency,
        amount: _transactionController.amount.toString(),
        transactionCompleted: () {},
        transactionNotCompleted: () {},
      );
      log(ref.toString());
    }
  }

  Future<void> _saveTransaction() async {
    await TransactionProvider().saveTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 37.height()),
        const UnderlinedContainer(text: StringManager.fundWallet),
        SizedBox(height: 87.height()),
        TextField(
          decoration: const InputDecoration(prefixText: "N"),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: TransactionController().updateAmount,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 18.height()),
        LoadingButton(label: StringManager.proceed, onPressed: _makePayment),
        SizedBox(height: 91.height()),
        Image.asset(AssetManager.logoMedium),
        SizedBox(height: 85.height()),
      ],
    );
  }
}
