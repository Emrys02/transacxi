import 'package:flutter/material.dart';

import '../../constants/managers/asset_manager.dart';
import '../../extensions/num_extension.dart';

class ErrorNotice extends StatelessWidget {
  const ErrorNotice(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.width()),
      child: Column(
        children: [
          Image.asset(AssetManager.error, height: 200.height()),
          SizedBox(height: 15.height()),
          Text(message, textAlign: TextAlign.center),
          SizedBox(height: 30.height()),
        ],
      ),
    );
  }
}
