import 'package:flutter/material.dart';

import '../../constants/managers/spacing_manager.dart';

class DashboardOptions extends StatelessWidget {
  const DashboardOptions({super.key, required String label, required IconData icon, required VoidCallback function})
      : _label = label,
        _icon = icon,
        _function = function;

  final String _label;
  final IconData _icon;
  final VoidCallback _function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _function,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SpacingManager.w10.width!, vertical: SpacingManager.h10.height!),
        decoration: BoxDecoration(color: const Color(0x4D888888), borderRadius: BorderRadius.circular(5)),
        child: Column(children: [Icon(_icon), SpacingManager.h10, Text(_label)]),
      ),
    );
  }
}
