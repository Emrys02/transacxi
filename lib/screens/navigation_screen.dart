import 'package:flutter/material.dart';

import '../handlers/navigation_screen_handler.dart';
import '../tabs/home_tab.dart';
import '../tabs/transactions_tab.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final _viewHanlder = NavigationViewStateHandler();
  final int _currentIndex = 0;

  Widget get _body {
    if (_currentIndex != 3) return const HomeTab();
    return const TransactionsTab();
  }

  Icon get _homeIcon {
    if (_currentIndex != 3) return const Icon(Icons.home_outlined);
    return const Icon(Icons.home_filled);
  }

  Icon get _scheduleIcon {
    if (_currentIndex != 3) return const Icon(Icons.schedule_outlined);
    return const Icon(Icons.schedule);
  }

  void _updateCurrentView(int value){
    _viewHanlder.changeCurrentView(value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _viewHanlder.value,
          items: [
            BottomNavigationBarItem(icon: _homeIcon, label: ""),
            const BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: ""),
            const BottomNavigationBarItem(icon: Icon(Icons.swap_horiz_rounded), label: ""),
            BottomNavigationBarItem(icon: _scheduleIcon, label: ""),
          ],
          onTap: _updateCurrentView,
        ),
      ),
    );
  }
}
