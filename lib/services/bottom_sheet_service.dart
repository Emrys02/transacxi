import 'package:flutter/material.dart';
import 'package:transacxi/constants/managers/asset_manager.dart';
import 'package:transacxi/constants/managers/spacing_manager.dart';

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
        children: [SpacingManager.h40, child],
      ),
    );
  }

  static void showErrorSheet(String message) {
    _showRemovableSheet(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: SpacingManager.w30.width!),
        child: Column(
          children: [
            Image.asset(AssetManager.error, height: SpacingManager.h200.height),
            SpacingManager.h15,
            Text(message, textAlign: TextAlign.center),
            SpacingManager.h30,
          ],
        ),
      ),
    );
  }
}
