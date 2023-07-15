import 'package:flutter/material.dart';

import '../../constants/managers/text_style_manager.dart';
import '../../extensions/num_extension.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({required this.label, this.onPressed, super.key});
  final Future<void> Function()? onPressed;
  final String label;
  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isLoading = false;

  void _submit() async {
    if (widget.onPressed == null) return;
    setState(() {
      _isLoading = !_isLoading;
    });
    await widget.onPressed!();
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Widget get _child {
    if (!_isLoading) return Text(widget.label, style: TextStyles.w400s11);
    return SizedBox(height: 20.height(), width: 20.height(), child: const CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _isLoading ? null : _submit,
      color: const Color(0xFFFF0000),
      disabledColor: const Color(0xFFFF0000),
      shape: const StadiumBorder(),
      padding: EdgeInsets.symmetric(vertical: 10.height()),
      minWidth: 316.width(),
      child: _child,
    );
  }
}
