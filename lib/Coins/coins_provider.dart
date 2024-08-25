import 'package:flutter/foundation.dart';

class CoinProvider with ChangeNotifier {
  int _coins = 50;

  int get coins => _coins;

  // Method to add coins
  void addCoins(int amount) {
    _coins += amount;
    notifyListeners();
    print("totalafter add $_coins");
  }

  // Method to deduct coins
  bool deductCoins(int amount) {
    if (_coins >= amount) {
      _coins -= amount;
      notifyListeners();
      print("totalafter add $_coins");

      return true;
    }
    return false; // Not enough coins to deduct
  }
}
