import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutterwave_standard/flutterwave.dart';

import '../../constants/constants.dart';
import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../controllers/transaction_controller.dart';
import '../../controllers/user_controller.dart';
import '../../extensions/num_extension.dart';
import '../../models/transaction.dart';
import '../../providers/transactions_provider.dart';
import '../../providers/user_details_provider.dart';
import '../../services/api_service.dart';
import '../elements/button_with_loading_indicator.dart';
import '../elements/provider_radio.dart';
import '../elements/underlined_container.dart';

class EnterAmount extends StatefulWidget {
  const EnterAmount({super.key});

  @override
  State<EnterAmount> createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  final paystackPlugin = PaystackPlugin();
  final _transactionController = TransactionController();
  final _userController = UserController();

  @override
  void initState() {
    paystackPlugin.initialize(publicKey: kPaystackPublicKey);
    super.initState();
  }

  @override
  void dispose() {
    _transactionController.dispose();
    super.dispose();
  }

  Future<void> _makePayment() async {
    if (_transactionController.amount == 0) return;
    _transactionController.updateTxRef = DateTime.now().microsecondsSinceEpoch.toString();
    _transactionController.updateTransactionType = TransactionType.credit;
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
      if (ref.status == "completed") {
        await _saveTransaction();
        await _updateBalance();
      }
    } else if (_transactionController.provider == Provider.paystack) {
      await ApiService.initializePaystack(email: _userController.currentUser.email, amount: _transactionController.amount);
      if (!mounted) return;
      final ref = await paystackPlugin.checkout(
        context,
        charge: Charge()
          ..amount = _transactionController.amount * 100
          ..currency = _transactionController.currency
          ..email = _userController.currentUser.email
          ..reference = _transactionController.txRef
          ..accessCode = _transactionController.txRef,
      );
      log(ref.message.toString());
      log(ref.status.toString());
      if (ref.status) {
        await _saveTransaction();
        await _updateBalance();
      }
    }
  }

  Future<void> _saveTransaction() async {
    await TransactionProvider.saveTransactions();
  }

  Future<void> _updateBalance() async {
    await UserDetailsProvider.updateBalance();
    if (mounted) Navigator.of(context).pop();
  }

  void _changeProvider(Provider? provider) {
    if (provider == null) return;
    setState(() => _transactionController.updateProvider = provider);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 37.height()),
        const UnderlinedContainer(text: StringManager.fundWallet, color: Color(0xFF6A6969), textColor: Color(0xFF000000)),
        SizedBox(height: 87.height()),
        SizedBox(
          width: 225.width(),
          child: TextField(
            decoration: const InputDecoration(
              filled: false,
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(),
            ),
            textAlign: TextAlign.center,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: TransactionController().updateAmount,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(height: 18.height()),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.width()),
          height: 50.height(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PaymentProviderRadio(
                color: const Color(0xFF0BA4DB),
                logo: AssetManager.paystackIcon,
                provider: Provider.paystack,
                text: "Paystack",
                onTap: _changeProvider,
              ),
              PaymentProviderRadio(
                color: const Color(0xFFFB9129),
                logo: AssetManager.flutterwaveIcon,
                provider: Provider.flutterwave,
                text: "Flutterwave",
                onTap: _changeProvider,
              ),
            ],
          ),
        ),
        SizedBox(height: 18.height()),
        LoadingButton(label: StringManager.proceed, onPressed: _makePayment),
        Visibility(
          visible: MediaQuery.viewInsetsOf(context).bottom < 1,
          replacement: SizedBox(height: MediaQuery.viewInsetsOf(context).bottom + 10),
          child: Column(
            children: [
              SizedBox(height: 91.height()),
              Image.asset(AssetManager.logoMedium),
              SizedBox(height: 85.height()),
            ],
          ),
        ),
      ],
    );
  }
}
