import 'package:flutter/material.dart';

import '../../extensions/num_extension.dart';

class UnderlinedContainer extends StatelessWidget {
  const UnderlinedContainer({super.key, required String text}) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.height(), bottom: 10.height(), left: 10.width(), right: 20.width()),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFb9b6b6)))),
      child: Text(_text),
    );
  }
}
