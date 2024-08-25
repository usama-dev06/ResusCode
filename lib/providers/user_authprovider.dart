import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuthProvider with ChangeNotifier {
  String? _userId;
  String? _username;

  // Constructor
  UserAuthProvider();

  // Initialize the user ID
  void initializeUser(String userId, String username) {
    _userId = userId;
    _username = username;
    notifyListeners();
  }

  // Get the current user ID
  String? get userId => _userId;

  // Get the current username
  String? get username => _username;

  // Set the current user ID
  void setUserId(String? userId) {
    _userId = userId;
    notifyListeners();
  }

  // Set the current username
  void setUsername(String? username) {
    _username = username;
    notifyListeners();
  }

  // Check if the user is authenticated
  bool get isAuthenticated => _userId != null;

  // Sign out the user
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Clear user-related data during logout
      _userId = null;
      _username = null;
      notifyListeners();
    } catch (e) {
      // Handle sign-out errors if any
      print("Error signing out: $e");
    }
  }
}
