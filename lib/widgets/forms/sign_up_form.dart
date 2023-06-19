import 'package:flutter/material.dart';
import 'package:transacxi/constants/managers/spacing_manager.dart';

import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../constants/managers/text_style_manager.dart';
import '../../constants/screen_size.dart';
import '../../handlers/auth_view_handler.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _authViewState = AuthViewStateHandler();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize.width,
      height: ScreenSize.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(top: 0, child: Image.asset(AssetManager.signUpBackground)),
          Positioned(
            top: SpacingManager.h315.height,
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
                  const TextField(decoration: InputDecoration(hintText: StringManager.fulName)),
                  SpacingManager.h10,
                  const TextField(decoration: InputDecoration(hintText: StringManager.emailAddress)),
                  SpacingManager.h10,
                  const TextField(decoration: InputDecoration(hintText: StringManager.password)),
                  SpacingManager.h10,
                  const TextField(decoration: InputDecoration(hintText: StringManager.confirmPassword)),
                  SpacingManager.h20,
                  MaterialButton(
                    onPressed: () {},
                    color: const Color(0xFFFF0000),
                    shape: const StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: SpacingManager.h10.height!),
                    minWidth: SpacingManager.w316.width,
                    child: const Text(StringManager.signUp, style: TextStyles.w400s11),
                  ),
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
