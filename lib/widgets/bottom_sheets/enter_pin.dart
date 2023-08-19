import 'package:flutter/material.dart';
import 'package:transacxi/extensions/num_extension.dart';

import '../../constants/managers/asset_manager.dart';
import '../../constants/managers/string_manager.dart';
import '../../controllers/user_controller.dart';
import '../../services/bottom_sheet_service.dart';
import '../elements/underlined_container.dart';

class EnterPin extends StatefulWidget {
  const EnterPin({super.key});

  @override
  State<EnterPin> createState() => _EnterPinState();
}

class _EnterPinState extends State<EnterPin> {
  final _text = List.generate(9, (index) => "${index + 1}");
  final _errorMessage = "Incorrect pin";
  bool _hasError = false;

  final _textController = TextEditingController();
  final _userController = UserController();

  void _updateController(String value) {
    _textController.text = _textController.text + value;
    _hasError = false;
    if (_textController.text.length >= 4) {
      if (_textController.text != _userController.currentUser.pin) _hasError = true;
      _textController.clear();
      _performAction();
    }
    setState(() {});
  }

  void _performAction() {
    Navigator.of(context).pop();
    BottomSheetService.showProcessingSheet();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 275.width(),
      child: Column(
        children: [
          const UnderlinedContainer(text: StringManager.pin, color: Color(0xFF6A6969), textColor: Colors.black),
          SizedBox(height: 47.height()),
          SizedBox(
            height: 27.height(),
            width: 260.width(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_textController.text.split("").isNotEmpty) const CircleAvatar(radius: 5, backgroundColor: Color(0xFF333333)),
                    Container(
                      width: 50.width(),
                      height: 1.height(),
                      decoration: const BoxDecoration(color: Color(0xFF463F3F)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_textController.text.split("").length > 1) const CircleAvatar(radius: 5, backgroundColor: Color(0xFF333333)),
                    Container(
                      width: 50.width(),
                      height: 1.height(),
                      decoration: const BoxDecoration(color: Color(0xFF463F3F)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_textController.text.split("").length > 2) const CircleAvatar(radius: 5, backgroundColor: Color(0xFF333333)),
                    Container(
                      width: 50.width(),
                      height: 1.height(),
                      decoration: const BoxDecoration(color: Color(0xFF463F3F)),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_textController.text.split("").length > 3) const CircleAvatar(radius: 5, backgroundColor: Color(0xFF333333)),
                    Container(
                      width: 50.width(),
                      height: 1.height(),
                      decoration: const BoxDecoration(color: Color(0xFF463F3F)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_hasError) Text(_errorMessage, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          SizedBox(height: 61.height()),
          SizedBox(
            height: 248.height(),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 70.width(), mainAxisSpacing: 36.height()),
              itemCount: 9,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _updateController(_text.elementAt(index)),
                  splashColor: const Color(0xCC000000),
                  borderRadius: BorderRadius.circular(45.width()),
                  child: Container(
                    height: 45.width(),
                    width: 45.width(),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0x80000000), width: 0.5)),
                    child: Text(_text.elementAt(index)),
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: () => _updateController("0"),
            splashColor: const Color(0xCC000000),
            borderRadius: BorderRadius.circular(45.width()),
            child: Container(
              height: 45.width(),
              width: 45.width(),
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0x80000000), width: 0.5)),
              child: const Text("0"),
            ),
          ),
          SizedBox(height: 102.height()),
          Image.asset(AssetManager.logoMini),
          SizedBox(height: 46.width()),
        ],
      ),
    );
  }
}
