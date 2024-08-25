import 'package:flutter/material.dart';

import '../Levels/data.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserOutlineData {
  final String userId;
  final Map<String, bool> outlineStatusMap;

  UserOutlineData({
    required this.userId,
    required this.outlineStatusMap,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'outlineStatusMap': outlineStatusMap,
    };
  }
}

class UserOutlineDataService {
  Future<void> saveUserOutlineData(
      UserOutlineData userOutlineData, String customDocId) async {
    try {
      CollectionReference outlineDataCollection =
          FirebaseFirestore.instance.collection('user_outline_data');

      // Specify the user's document using their userID
      DocumentReference userDocument =
          outlineDataCollection.doc(userOutlineData.userId);

      // Specify a custom sub-collection for the user
      CollectionReference customSubcollection =
          userDocument.collection('custom_data');

      // Set the data within the custom document
      await customSubcollection.doc(customDocId).set(
        {
          'userId': userOutlineData.userId,
          'outlineStatusMap': userOutlineData.outlineStatusMap,
        },
      );

      print('User outline data saved to Firestore successfully!');
    } catch (e) {
      print('Error saving user outline data to Firestore: $e');
    }
  }

  Future<UserOutlineData?> loadUserOutlineData(
      String userId, String Key) async {
    try {
      DocumentSnapshot userOutlineSnapshot = await FirebaseFirestore.instance
          .collection('user_outline_data')
          .doc(userId)
          .collection('custom_data') // Access the custom sub-collection
          .doc('$Key') // Use the key to access the custom document
          .get();

      if (userOutlineSnapshot.exists) {
        final userData = userOutlineSnapshot.data() as Map<String, dynamic>;
        final outlineStatusMap =
            Map<String, bool>.from(userData['outlineStatusMap']);

        return UserOutlineData(
          userId: userId,
          outlineStatusMap: outlineStatusMap,
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error loading user outline data from Firestore: $e');
      return null;
    }
  }
}

class OutlineProvider extends ChangeNotifier {
  List<List<bool>> _outlineStatusList = [];
  final String userId; // Add a user ID field

  OutlineProvider(this.userId, List<LevelDataClass> levelsData) {
    _outlineStatusList = List.generate(levelsData.length, (index) {
      // Get the number of sub-levels for the current levelData at the given index
      int numberOfSubLevels = levelsData[index].subLevels.length;

      // Initialize the outline status for this level
      return List.generate(numberOfSubLevels, (subIndex) => false);
    });
  }

  bool getOutlineStatus(int levelIndex, int subLevelIndex) {
    return _outlineStatusList[levelIndex][subLevelIndex];
  }

  void toggleOutline(int levelIndex, int subLevelIndex, bool value) {
    _outlineStatusList[levelIndex][subLevelIndex] = value;
    notifyListeners();
  }

  // Method to reset the completion status when a user logs out
  void reset() {
    _outlineStatusList.clear(); // Clear the completion status map
    notifyListeners(); // Notify listeners that the state has changed
  }
}
