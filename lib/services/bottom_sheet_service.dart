import 'package:flutter/material.dart';

import '../constants/screen_size.dart';
import '../extensions/num_extension.dart';
import '../helpers/global_variables.dart';
import '../widgets/bottom_sheets/enter_pin.dart';
import '../widgets/bottom_sheets/error_notice.dart';
import '../widgets/bottom_sheets/fund_wallet.dart';
import '../widgets/bottom_sheets/processing_transaction.dart';
import '../widgets/bottom_sheets/transfer_destination.dart';
import '../widgets/bottom_sheets/transfer_details.dart';

class BottomSheetService {
  BottomSheetService._();

  static Future<dynamic> _showRemovableSheet(Widget child, {bool hideSpace = false, bool isDismissible = true}) {
    return showModalBottomSheet(
      context: navigationKey.currentContext!,
      isDismissible: isDismissible,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(navigationKey.currentContext!).colorScheme.secondary,
      builder: (context) => Wrap(
        alignment: WrapAlignment.center,
        children: [if (!hideSpace) SizedBox(height: 40.height()), SizedBox(width: ScreenSize.width), child],
      ),
    );
  }

  static void showErrorSheet(String message) {
    _showRemovableSheet(ErrorNotice(message));
  }

  static Future<void> showFundingSheet() {
    return _showRemovableSheet(const FundWallet(),isDismissible: false);
  }

  static Future<void> showTransferDestinationSheet() {
    return _showRemovableSheet(const TransferDestination());
  }

  static Future<void> showTransferDetailsSheet() {
    return _showRemovableSheet(const TransferDetails());
  }

  static Future<void> showEnterPinSheet() {
    return _showRemovableSheet(const EnterPin(), hideSpace: true);
  }

  static Future<void> showProcessingSheet() {
    return _showRemovableSheet(const ProcessingTransaction(), hideSpace: true, isDismissible: false);
  }
}
