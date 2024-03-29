import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class FundWallet extends StatefulWidget {
  const FundWallet({super.key});

  @override
  State<FundWallet> createState() => _FundWalletState();
}

class _FundWalletState extends State<FundWallet> {
  final paystackPlugin = PaystackPlugin();
  final _transactionController = TransactionController();
  final _userController = UserController();
  bool _isDisabled = false;

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
    setState(() => _isDisabled = true);
    _transactionController.updateTxRef = DateTime.now().microsecondsSinceEpoch.toString();
    _transactionController.transactionType = TransactionType.credit;
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
      if (ref.status == "completed") {
        await _saveTransaction();
        await _updateBalance();
      }
    } else if (_transactionController.provider == Provider.paystack) {
      await ApiService.initializePaystack(email: _userController.currentUser.email, amount: _transactionController.amount);
      if (!mounted) return;
      final ref = await paystackPlugin.checkout(
        context,
        fullscreen: true,
        method: CheckoutMethod.card,
        charge: Charge()
          ..amount = _transactionController.amount * 100
          ..currency = _transactionController.currency
          ..email = _userController.currentUser.email
          ..reference = _transactionController.txRef
          ..accessCode = _transactionController.accessCode,
        logo: SvgPicture.asset(AssetManager.logoMini),
      );
      log(ref.message.toString());
      log(ref.status.toString());
      if (ref.status) {
        await _saveTransaction();
        await _updateBalance();
      }
    }
    setState(() => _isDisabled = false);
  }

  Future<void> _saveTransaction() async {
    await TransactionProvider.saveCreditTransactions();
  }

  Future<void> _updateBalance() async {
    await UserDetailsProvider.updateBalance();
    if (mounted) Navigator.of(context).pop();
  }

  void _changeProvider(Provider? provider) {
    if (provider == null) return;
    setState(() => _transactionController.provider = provider);
  }

  void _updateAmount(String? value) {
    TransactionController().updateAmount = value;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Column(
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
              onChanged: _updateAmount,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: LoadingButton(label: StringManager.proceed, onPressed: _makePayment)),
              SizedBox(width: 20.width()),
              Expanded(child: OutlinedButton(onPressed: _isDisabled ? null : Navigator.of(context).pop, child: const Text(StringManager.cancel))),
            ],
          ),
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
      ),
    );
  }
}
