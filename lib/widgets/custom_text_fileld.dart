import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {required String hintText,
      bool isPassword = false,
      List<TextInputFormatter>? inputFormatters,
      void Function(String)? onChanged,
      String? Function(String?)? validator,
      required TextInputType keyboardType,
      TextCapitalization textCapitalization = TextCapitalization.none,
      super.key})
      : _inputFormatters = inputFormatters,
        _onChanged = onChanged,
        _validator = validator,
        _isPassword = isPassword,
        _hintText = hintText,
        _keyboardType = keyboardType,
        _textCapitalization = textCapitalization;
  final String _hintText;
  final bool _isPassword;
  final String? Function(String?)? _validator;
  final void Function(String)? _onChanged;
  final List<TextInputFormatter>? _inputFormatters;
  final TextInputType _keyboardType;
  final TextCapitalization _textCapitalization;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool? _obscureText = widget._isPassword == false ? null : widget._isPassword;
  IconData get _icon {
    if (_obscureText == true) return Icons.visibility_rounded;
    return Icons.visibility_off_rounded;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:
          InputDecoration(hintText: widget._hintText, suffixIcon: !widget._isPassword ? null : IconButton(onPressed: _toggleVisibility, icon: Icon(_icon))),
      validator: widget._validator,
      onChanged: widget._onChanged,
      keyboardType: widget._keyboardType,
      inputFormatters: widget._inputFormatters,
      obscureText: _obscureText ?? false,
      textCapitalization: widget._textCapitalization,
    );
  }
}
