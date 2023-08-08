import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controllers/transaction_controller.dart';
import '../../extensions/num_extension.dart';
import '../../models/transaction.dart';

class PaymentProviderRadio extends StatefulWidget {
  const PaymentProviderRadio(
      {required Provider provider, required String text, required Color color, required String logo, void Function(Provider?)? onTap, super.key})
      : _color = color,
        _logo = logo,
        _provider = provider,
        _text = text,
        _onTap = onTap;
  final Provider _provider;
  final String _text;
  final Color _color;
  final String _logo;
  final void Function(Provider?)? _onTap;
  @override
  State<PaymentProviderRadio> createState() => _PaymentProviderRadioState();
}

class _PaymentProviderRadioState extends State<PaymentProviderRadio> {
  final _transactionController = TransactionController();

  Border? get _border {
    if (widget._provider == _transactionController.provider) return Border.all(color: widget._color);
    if (widget._onTap == null) return Border.all(color: Theme.of(context).colorScheme.onPrimary);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget._onTap == null ? null : () => widget._onTap!(widget._provider),
      child: Container(
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: _border),
        padding: EdgeInsets.only(right: 10.width()),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 40.width(),
              child: FittedBox(
                child: Radio(
                  value: widget._provider,
                  groupValue: _transactionController.provider,
                  onChanged: widget._onTap,
                ),
              ),
            ),
            SizedBox.square(dimension: 18.width(), child: SvgPicture.asset(widget._logo)),
            const SizedBox(width: 5),
            Text(widget._text),
          ],
        ),
      ),
    );
  }
}
