import 'package:flutter/material.dart';

import '../../constants/input_formatters.dart';
import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/spacing_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../constants/managers/text_style_manager.dart';
import '../../constants/screen_size.dart';
import '../../constants/validators/input_validators.dart';
import '../../controllers/new_user_controller.dart';
import '../../handlers/auth_view_handler.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_details_provider.dart';
import '../../screens/navigation_screen.dart';
import '../../services/bottom_sheet_service.dart';
import '../elements/button_with_loading_indicator.dart';
import '../elements/custom_text_fileld.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with WidgetsBindingObserver {
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
    FocusScope.of(context).unfocus();
    try {
      final ref = await AuthProvider.createUser();
      await UserDetailsProvider.createUser(ref);
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const NavigationScreen(),
        ));
      }
    } catch (e) {
      if (AuthProvider.completedAction) AuthProvider.deleteUser();
      BottomSheetService.showErrorSheet(e.toString());
    }
  }

  void _updateFullname(String value) {
    _newUserController.updateFullname = value;
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
            Positioned(top: 0, child: Image.asset(AssetManager.signUpBackground)),
            Positioned(
              top: SpacingManager.h315.height! - View.of(context).viewInsets.bottom / 3,
              child: Container(
                width: ScreenSize.width,
                padding: EdgeInsets.symmetric(horizontal: SpacingManager.w30.width!),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: SpacingManager.w10.width!),
                        padding: EdgeInsets.only(
                          top: SpacingManager.h10.height!,
                          bottom: SpacingManager.h10.height!,
                          left: SpacingManager.w10.width!,
                          right: SpacingManager.w50.width!,
                        ),
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFb9b6b6)))),
                        child: const Text(StringManager.signUp),
                      ),
                    ),
                    SpacingManager.h20,
                    CustomTextField(
                      hintText: StringManager.fullName,
                      inputFormatters: InputFormatters.fullname,
                      validator: InputValidators.fullname,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      onChanged: _updateFullname,
                    ),
                    SpacingManager.h10,
                    CustomTextField(
                      hintText: StringManager.emailAddress,
                      validator: InputValidators.email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: _updateEmail,
                    ),
                    SpacingManager.h10,
                    CustomTextField(
                      hintText: StringManager.password,
                      validator: InputValidators.createPassword,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      onChanged: _updatePassword,
                    ),
                    SpacingManager.h10,
                    const CustomTextField(
                      hintText: StringManager.confirmPassword,
                      validator: InputValidators.confirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                    ),
                    SpacingManager.h20,
                    LoadingButton(label: StringManager.signUp, onPressed: _submit),
                    SpacingManager.h30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: SpacingManager.w20.width, child: const Divider()),
                        SpacingManager.w10,
                        const Text(StringManager.haveAccount, style: TextStyles.w500s10),
                        GestureDetector(
                          onTap: _authViewState.changeCurrentView,
                          child: Text(StringManager.login, style: TextStyles.w500s10.copyWith(color: const Color(0xFFFF0000))),
                        ),
                        SpacingManager.w10,
                        SizedBox(width: SpacingManager.w20.width, child: const Divider()),
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
