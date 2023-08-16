import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/managers/asset_manager.dart';
import '../constants/managers/string_manager.dart';
import '../constants/screen_size.dart';
import '../constants/validators/input_validators.dart';
import '../extensions/num_extension.dart';
import '../providers/user_details_provider.dart';
import '../services/bottom_sheet_service.dart';
import '../widgets/elements/button_with_loading_indicator.dart';
import 'navigation_screen.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final _pinController = TextEditingController();
  final _key = GlobalKey<FormFieldState>();

  Future<void> _submit() async {
    if (!_key.currentState!.validate()) return;
    await UserDetailsProvider.updatePin(_pinController.text);
    if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavigationScreen()));
    try {} catch (e) {
      log(e.toString());
      BottomSheetService.showErrorSheet(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(width: ScreenSize.width, child: Image.asset(AssetManager.largeBackground, fit: BoxFit.cover)),
          Container(
            color: Theme.of(context).colorScheme.secondary,
            padding: EdgeInsets.symmetric(horizontal: 33.width()),
            width: 316.width(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 159.height()),
                TextFormField(
                  key: _key,
                  controller: _pinController,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.secondary,
                    border: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF888888))),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF888888))),
                    focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF888888))),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF888888))),
                    errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF888888))),
                    hintStyle: const TextStyle(color: Color(0xFF888888)),
                    hintText: StringManager.inputYourPin,
                  ),
                  validator: InputValidators.pin,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF888888)),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 30.height()),
                SizedBox(width: 124.width(), child: LoadingButton(label: StringManager.proceed, onPressed: _submit)),
                SizedBox(height: 58.height()),
                Image.asset(AssetManager.logoMedium),
                SizedBox(height: 34.height()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
