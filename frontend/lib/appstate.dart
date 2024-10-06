import 'package:flutter/cupertino.dart';

class AppState {
  // Private constructor
  AppState._internal();

  // Singleton instance
  static final AppState _instance = AppState._internal();

  // Factory constructor for returning the same instance
  factory AppState() {
    return _instance;
  }

  // Private variables
  final ValueNotifier<int> _selectedPageIndex = ValueNotifier(0);
  final ValueNotifier<bool> _toShowNav = ValueNotifier(true);

  ValueNotifier<int> get selectedPageIndexNotifier => _selectedPageIndex;

  set selectedPageIndex(int value) {
    if(_selectedPageIndex.value != value){
      _selectedPageIndex.value = value;
    }
  }

  // Getter for the toShowNav ValueNotifier
  ValueNotifier<bool> get toShowNavNotifier {
    return _toShowNav;
  }

  void toShowNavTrue() {
    if(_toShowNav.value != true){
      _toShowNav.value = true; // Update the ValueNotifier's value
    }
  }

  void toShowNavFalse() {
    if(_toShowNav.value != false){
      _toShowNav.value = false; // Update the ValueNotifier's value
    }
  }
}
