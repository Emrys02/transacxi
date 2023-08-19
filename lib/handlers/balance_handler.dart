import 'package:flutter/material.dart';

class BalanceHandler extends ValueNotifier<double>{
  BalanceHandler():super(0);

  void updateBalance(double newValue){
    value = newValue;
  }

  void reset(){
    value = 0;
  }

}