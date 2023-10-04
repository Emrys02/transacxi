import 'package:flutter/material.dart';

import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../controllers/transaction_controller.dart';
import '../../extensions/num_extension.dart';
import '../../models/transaction.dart';
import '../../services/bottom_sheet_service.dart';
import '../elements/underlined_container.dart';

class TransferDestination extends StatefulWidget {
  const TransferDestination({super.key});

  @override
  State<TransferDestination> createState() => _TransferDestinationState();
}

class _TransferDestinationState extends State<TransferDestination> {
  final _transactionController = TransactionController();

  void _selectDestination({String? destination}) async {
    _transactionController.transactionType = TransactionType.debit;
    if (destination == null) {
      _transactionController.destination = "";
    } else {
      _transactionController.destination = destination;
    }
    Navigator.of(context).pop();
    BottomSheetService.showTransferDetailsSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 29.width()),
      child: Column(
        children: [
          SizedBox(height: 37.height()),
          const UnderlinedContainer(text: StringManager.transfer, color: Color(0xFF6A6969), textColor: Color(0xFF000000)),
          SizedBox(height: 87.height()),
          ElevatedButton(
            onPressed: () => _selectDestination(destination: "wallet"),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onSecondary),
              foregroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onSurface),
            ),
            child: const Text(StringManager.anotherWallet),
          ),
          SizedBox(height: 33.height()),
          ElevatedButton(
            onPressed: _selectDestination,
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onSecondary),
              foregroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onSurface),
            ),
            child: const Text(StringManager.anotherBank),
          ),
          SizedBox(height: 91.height()),
          Image.asset(AssetManager.logoMedium),
          SizedBox(height: 85.height()),
        ],
      ),
    );
  }
}
