import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LevelCompletionProvider extends ChangeNotifier {
  Map<String, bool> _completionStatus = {};

  // Initialize the completion status from Firestore
  Future<void> init(String userId) async {
    try {
      // Fetch the completion status for the user from Firestore
      DocumentSnapshot userStatusDoc = await FirebaseFirestore.instance
          .collection('user_level_status')
          .doc(userId)
          .get();

      if (userStatusDoc.exists) {
        final data = userStatusDoc.data();
        if (data is Map<String, dynamic>) {
          // Check if the data is a map before casting
          _completionStatus = Map<String, bool>.from(data);

          print("fchin\n bbb $_completionStatus");
          notifyListeners();
        } else {
          print('Error: Firestore data is not in the expected format');
        }
      }
    } catch (e) {
      print('Error initializing level completion status: $e');
    }
  }

  // Get the completion status for a specific level
  bool isLevelCompleted(int levelIndex) {
    final key = 'level_$levelIndex';
    return _completionStatus[key] ?? false;
  }

  // Mark a level as completed
  Future<void> markLevelCompleted(int levelIndex, String userId) async {
    final key = 'level_$levelIndex';
    _completionStatus[key] = true;

    try {
      // Update the completion status in Firestore
      await FirebaseFirestore.instance
          .collection('user_level_status')
          .doc(userId)
          .set(
              _completionStatus); // You may need to update only this specific key-value pair
      notifyListeners();
    } catch (e) {
      print('Error marking level as completed: $e');
    }
  }

  // Method to reset the completion status when a user logs out
  void reset() {
    _completionStatus.clear(); // Clear the completion status map
    notifyListeners(); // Notify listeners that the state has changed
  }
}
