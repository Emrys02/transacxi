import 'package:flutter/material.dart';

import '../constants/managers/asset_manager.dart';
import '../constants/screen_size.dart';
import '../extensions/num_extension.dart';
import '../helpers/global_variables.dart';

class BottomSheetService {
  BottomSheetService._();

  static _showRemovableSheet(Widget child) {
    showModalBottomSheet(
      context: navigationKey.currentContext!,
      isDismissible: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      builder: (context) => Wrap(
        alignment: WrapAlignment.center,
        children: [SizedBox(height: 40.height()), SizedBox(width: ScreenSize.width), child],
      ),
    );
  }

  static void showErrorSheet(String message) {
    _showRemovableSheet(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.width()),
        child: Column(
          children: [
            Image.asset(AssetManager.error, height: 200.height()),
            SizedBox(height: 15.height()),
            Text(message, textAlign: TextAlign.center),
            SizedBox(height: 30.height()),
          ],
        ),
      ),
    );
  }
}
