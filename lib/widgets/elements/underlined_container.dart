import 'package:flutter/material.dart';

import '../../extensions/num_extension.dart';

class UnderlinedContainer extends StatelessWidget {
  const UnderlinedContainer({super.key, required String text, Color? color, Color? textColor})
      : _text = text,
        _color = color,
        _textColor = textColor;

  final String _text;
  final Color? _color;
  final Color? _textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.height(), bottom: 10.height(), left: 10.width(), right: 20.width()),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _color ?? const Color(0xFFb9b6b6)))),
      child: Text(_text, style: TextStyle(color: _textColor)),
    );
  }
}
