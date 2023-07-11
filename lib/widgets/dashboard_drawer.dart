import 'package:flutter/material.dart';

import '../constants/managers/asset_manager.dart';
import '../constants/managers/spacing_manager.dart';
import '../controllers/user_controller.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  final _userController = UserController();
  Widget get _image {
    if (_userController.currentUser.profileImage.isNotEmpty) return Image.network(_userController.currentUser.profileImage);
    return Image.asset(AssetManager.transactionIcon);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: SpacingManager.h40.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(SpacingManager.h40.height!),
              child: _image,
            ),
          ),
          const Text("full name"),
          const Text("email"),
          const Text("Change Pin"),
          const Text("Logout"),
        ],
      ),
    );
  }
}
