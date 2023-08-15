import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../constants/managers/text_style_manager.dart';
import '../../constants/screen_size.dart';
import '../../constants/validators/input_validators.dart';
import '../../controllers/new_user_controller.dart';
import '../../extensions/num_extension.dart';
import '../../handlers/auth_view_handler.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_details_provider.dart';
import '../../screens/navigation_screen.dart';
import '../../services/api_service.dart';
import '../../services/bottom_sheet_service.dart';
import '../elements/button_with_loading_indicator.dart';
import '../elements/custom_text_fileld.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with WidgetsBindingObserver {
  final _authViewState = AuthViewStateHandler();
  final _formKey = GlobalKey<FormState>();
  final _newUserController = NewUserController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    if (View.of(context).viewInsets.bottom > 1) {
      setState(() {});
      return;
    }
    if (View.of(context).viewInsets.bottom < 1) {
      setState(() {});
      return;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      FocusScope.of(context).unfocus();
      final ref = await AuthProvider.login();
      await UserDetailsProvider.retrieveUserDetails(ref);
      await ApiService.retrieveFlutterwaveBanksList();
      await ApiService.retrievePaystackBanksList();
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavigationScreen()));
      }
    } on DioException catch (e) {
      log(e.toString());
      if (e.response!.statusCode! >= 500) {
        //TODO: provide proper handling
        BottomSheetService.showErrorSheet("An unknown error occured");
        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavigationScreen()));
        }
      } else {
        BottomSheetService.showErrorSheet(e.toString());
        if (AuthProvider.completedAction) AuthProvider.logOut();
      }
    } catch (e) {
      log(e.toString());
      if (AuthProvider.completedAction) AuthProvider.logOut();
      BottomSheetService.showErrorSheet(e.toString());
    }
  }

  void _updateEmail(String value) {
    _newUserController.updateEmail = value;
  }

  void _updatePassword(String value) {
    _newUserController.updatePassword = value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize.width,
      height: ScreenSize.height,
      child: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(top: 0, child: Image.asset(AssetManager.loginBackground)),
            Positioned(
              top: 435.height() - View.of(context).viewInsets.bottom / 3,
              child: Container(
                width: ScreenSize.width,
                padding: EdgeInsets.symmetric(horizontal: 30.width()),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 10.width()),
                        padding: EdgeInsets.only(
                          top: 10.height(),
                          bottom: 10.height(),
                          left: 10.width(),
                          right: 50.width(),
                        ),
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFb9b6b6)))),
                        child: const Text(StringManager.login),
                      ),
                    ),
                    SizedBox(height: 20.height()),
                    CustomTextField(
                      hintText: StringManager.emailAddress,
                      validator: InputValidators.email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: _updateEmail,
                    ),
                    SizedBox(height: 10.height()),
                    CustomTextField(
                      hintText: StringManager.password,
                      validator: InputValidators.password,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: _updatePassword,
                      isPassword: true,
                    ),
                    SizedBox(height: 20.height()),
                    LoadingButton(label: StringManager.login, onPressed: _submit),
                    SizedBox(height: 30.height()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 20.width(), child: const Divider()),
                        SizedBox(height: 10.width()),
                        const Text(StringManager.dontHaveAccount, style: TextStyles.w500s10),
                        GestureDetector(
                          onTap: _authViewState.changeCurrentView,
                          child: Text(StringManager.signup, style: TextStyles.w500s10.copyWith(color: const Color(0xFFFF0000))),
                        ),
                        SizedBox(height: 10.width()),
                        SizedBox(width: 20.width(), child: const Divider()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
