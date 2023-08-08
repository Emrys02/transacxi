import 'package:flutter/material.dart';

import '../constants/screen_size.dart';
import '../extensions/num_extension.dart';
import '../helpers/global_variables.dart';
import '../widgets/bottom_sheets/error_notice.dart';
import '../widgets/bottom_sheets/fund_wallet.dart';

class BottomSheetService {
  BottomSheetService._();

  static Future<dynamic> _showRemovableSheet(Widget child) {
    return showModalBottomSheet(
      context: navigationKey.currentContext!,
      isDismissible: true,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(navigationKey.currentContext!).colorScheme.secondary,
      builder: (context) => Wrap(
        alignment: WrapAlignment.center,
        children: [SizedBox(height: 40.height()), SizedBox(width: ScreenSize.width), child],
      ),
    );
  }

  static void showErrorSheet(String message) {
    _showRemovableSheet(ErrorNotice(message));
  }

  static Future<void> showFundingSheet() {
    return _showRemovableSheet(const FundWallet());
  }
}
