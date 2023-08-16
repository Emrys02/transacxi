import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transacxi/services/api_service.dart';

import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../controllers/transaction_controller.dart';
import '../../extensions/num_extension.dart';
import '../../helpers/global_variables.dart';
import '../../models/bank.dart';
import '../../providers/transactions_provider.dart';
import '../elements/button_with_loading_indicator.dart';
import '../elements/underlined_container.dart';

class TransferDetails extends StatefulWidget {
  const TransferDetails({super.key});

  @override
  State<TransferDetails> createState() => _TransferDetailsState();
}

class _TransferDetailsState extends State<TransferDetails> {
  final _transactionController = TransactionController();
  bool _isLoading = false;
  String? _accountName;
  String? _error;

  void _updateDestination(Bank? value) {
    if (value == null) return;
    _transactionController.updateDestinaiton = value.name;
    _transactionController.updatePaystackCode = value.paystackCode;
    _transactionController.updateFlutterwaveCode = value.flutterwaveCode;
    _accountName = null;
    _error = null;
    setState(() {});
  }

  void _updateAccountNumber(String? value) {
    if (value == null) return;
    _transactionController.updateAccountNumber = value;
  }

  void _updateReceiverUsername(String? value) {
    if (value == null) return;
    _transactionController.updateReceiverUsername = value;
  }

  Future<void> _verifyIdentity() async {
    setState(() {
      _isLoading = !_isLoading;
    });
    try {
      if (_transactionController.paystackCode.isNotEmpty) {
        _accountName = await ApiService.paystackVerifyAccount();
      } else if (_transactionController.flutterwaveCode.isNotEmpty) {
        _accountName = await ApiService.flutterwaveVerifyAccount();
      } else {
        _accountName = await TransactionProvider.verifyIdentity();
      }
      _error = null;
    } catch (e) {
      _error = "An error occured";
      log(e.toString());
    }
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  void dispose() {
    _transactionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.width()),
      child: Column(
        children: [
          SizedBox(height: 37.height()),
          const UnderlinedContainer(text: StringManager.transfer, color: Color(0xFF6A6969), textColor: Color(0xFF000000)),
          SizedBox(height: 55.height()),
          Visibility(
            visible: _transactionController.destination != "wallet",
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField(
                  items: _isLoading ? null : [for (var bank in banks) DropdownMenuItem(value: bank, child: Text(bank.name))],
                  onChanged: _updateDestination,
                  isExpanded: true,
                  alignment: Alignment.center,
                  dropdownColor: const Color(0xFF6A6969),
                  decoration: const InputDecoration(fillColor: Color(0xFF6A6969)),
                  style: Theme.of(context).inputDecorationTheme.hintStyle!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                  hint: const Text(StringManager.destinationBank),
                ),
                SizedBox(height: 13.height()),
              ],
            ),
          ),
          Visibility(
            visible: _transactionController.destination != "wallet",
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  enabled: !_isLoading,
                  decoration: const InputDecoration(hintText: StringManager.accountNumber, fillColor: Color(0xFF6A6969)),
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                  onChanged: _updateAccountNumber,
                ),
                if (_accountName != null) Text(_accountName!, style: const TextStyle(color: Colors.green)),
                if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
                SizedBox(height: 13.height()),
              ],
            ),
          ),
          Visibility(
            visible: _transactionController.destination == "wallet",
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  enabled: !_isLoading,
                  decoration: const InputDecoration(hintText: StringManager.username2, fillColor: Color(0xFF6A6969)),
                  textAlign: TextAlign.center,
                  onChanged: _updateReceiverUsername,
                ),
                if (_accountName != null) Text(_accountName!, style: const TextStyle(color: Colors.green)),
                if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
                SizedBox(height: 13.height()),
              ],
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(fillColor: Color(0xFF6A6969), hintText: StringManager.amountToTransfer),
            textAlign: TextAlign.center,
          ),
          Visibility(
            visible: _transactionController.destination == "wallet",
            replacement: SizedBox(height: 18.height()),
            child: SizedBox(height: 48.height()),
          ),
          Visibility(
            visible: MediaQuery.viewInsetsOf(context).bottom < 1,
            replacement: SizedBox(height: MediaQuery.viewInsetsOf(context).bottom),
            child: Column(
              children: [
                Visibility(
                  visible: _accountName == null,
                  replacement: const LoadingButton(label: StringManager.proceed),
                  child: LoadingButton(label: StringManager.verifyAccount, onPressed: _verifyIdentity),
                ),
                SizedBox(height: 91.height()),
                Image.asset(AssetManager.logoMini),
                SizedBox(height: 76.height())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
