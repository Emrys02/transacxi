import 'package:flutter/material.dart';

import '../constants/managers/asset_manager.dart';
import '../controllers/user_controller.dart';
import '../extensions/num_extension.dart';

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
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(50))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50.width(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.width()),
              child: _image,
            ),
          ),
          SizedBox(height: 60.height()),
          Text(_userController.currentUser.fullname),
          SizedBox(height: 66.height()),
          Text(_userController.currentUser.email),
          SizedBox(height: 23.height()),
          const Text("Change Pin"),
          const Text("Logout"),
        ],
      ),
    );
  }
}
