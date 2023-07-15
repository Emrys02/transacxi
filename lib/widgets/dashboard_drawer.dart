import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/user_controller.dart';
import '../extensions/num_extension.dart';
import '../providers/user_details_provider.dart';
import 'elements/button_with_loading_indicator.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({super.key});

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  final _userController = UserController();
  bool _uploadingImage = false;
  Widget get _image {
    if (_userController.currentUser.profileImage.isNotEmpty) return Image.network(_userController.currentUser.profileImage);
    return const Icon(Icons.camera_alt);
  }

  void _updateProfileImage() async {
    final ref = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (ref == null) return;
    setState(() {
      _uploadingImage = !_uploadingImage;
    });
    try {
      await UserDetailsProvider.uploadProfileImage(File(ref.path));
    } catch (e) {
      print(e);
    }
    setState(() {
      _uploadingImage = !_uploadingImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(50))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _updateProfileImage,
            child: CircleAvatar(
              radius: 50.width(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.width()),
                child: _image,
              ),
            ),
          ),
          SizedBox(height: 60.height()),
          Text(_userController.currentUser.fullname),
          SizedBox(height: 66.height()),
          Text(_userController.currentUser.email),
          SizedBox(height: 23.height()),
          SizedBox(width: 155.width(), child: const LoadingButton(label: "Change Pin")),
          SizedBox(height: 11.height()),
          TextButton(onPressed: () {}, child: const Text("Logout")),
        ],
      ),
    );
  }
}
