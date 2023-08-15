import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../controllers/transaction_controller.dart';
import '../../extensions/num_extension.dart';
import '../../helpers/global_variables.dart';
import '../../models/bank.dart';
import '../elements/underlined_container.dart';

class TransferDetails extends StatefulWidget {
  const TransferDetails({super.key});

  @override
  State<TransferDetails> createState() => _TransferDetailsState();
}

class _TransferDetailsState extends State<TransferDetails> {
  final _transactionController = TransactionController();

  void _updateDestination(Bank? value) {
    if (value == null) return;
    _transactionController.updateDestinaiton = value.name;
    _transactionController.updatePaystackCode = value.paystackCode;
    _transactionController.updateFlutterwaveCode = value.flutterwaveCode;
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
                  items: [for (var bank in banks) DropdownMenuItem(value: bank, child: Text(bank.name))],
                  onChanged: _updateDestination,
                  dropdownColor: const Color(0xFF6A6969),
                  isExpanded: true,
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
                  decoration: const InputDecoration(hintText: StringManager.accountNumber, fillColor: Color(0xFF6A6969)),
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                ),
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
                  decoration: const InputDecoration(fillColor: Color(0xFF6A6969)),
                  textAlign: TextAlign.center,
                ),
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
          SizedBox(height: 91.height()),
          Image.asset(AssetManager.logoMini),
          SizedBox(height: 76.height()),
        ],
      ),
    );
  }
}