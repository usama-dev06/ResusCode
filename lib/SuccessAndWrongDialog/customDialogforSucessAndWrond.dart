import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Levels/data.dart';
import 'coinearned.dart';
import 'wronganswer.dart';

void updateCompletionStatus(
  int getlvlindex,
) {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // Reference to the Firestore collection for user completion data
  final userCompletionCollection =
      FirebaseFirestore.instance.collection('user_completion_data');

  // Reference to the document for the current user and level
  final userLevelDocument = userCompletionCollection
      .doc(userId)
      .collection('levels')
      .doc(getlvlindex.toString());

  userLevelDocument.get().then((docSnapshot) {
    // Initialize the completion status if the document doesn't exist
    final data = docSnapshot.data() ??
        {
          'scenariosCompleted': false,
          //   'quizCompleted': false,
          'isCompleted': false,
        };

    // Update both scenariosCompleted and quizCompleted to true
    data['scenariosCompleted'] = true;
    // data['quizCompleted'] = true;

    // Update isCompleted based on both scenariosCompleted and quizCompleted
    data['isCompleted'] = true;

    // Save the updated data back to Firestore
    userLevelDocument.set(data);

    print('Completion status updated for Level $getlvlindex');
  }).catchError((error) {
    print('Error updating completion status: $error');
  });
}

void showResultDialog(
    bool isCorrect, BuildContext context, int getlvlindex, bool isscenario) {
  /*  if (isCorrect == true) {
    if (isscenario == true) {
      levelsDataFirebase[getlvlindex].scenariosCompleted = true;
      print("Scenario completed for Level $getlvlindex");
      if (levelsDataFirebase[getlvlindex].scenariosCompleted &&
          levelsDataFirebase[getlvlindex].quizCompleted == true) {
        levelsDataFirebase[getlvlindex].isCompleted = true;
        print("Scenario true completed  Level with both $getlvlindex");
      }
    }
    if (isscenario == false) {
      levelsDataFirebase[getlvlindex].quizCompleted = true;
      print("Quiz completed for Level $getlvlindex");
      if (levelsDataFirebase[getlvlindex].scenariosCompleted &&
          levelsDataFirebase[getlvlindex].quizCompleted == true) {
        levelsDataFirebase[getlvlindex].isCompleted = true;
        print("Scenario false completed  Level with both $getlvlindex");
      }
    }
  } else {
    if (isscenario == true) {
      levelsDataFirebase[getlvlindex].scenariosCompleted = false;
      print("Scenario not completed for Level $getlvlindex");
      if (levelsDataFirebase[getlvlindex].scenariosCompleted &&
          levelsDataFirebase[getlvlindex].quizCompleted == true) {
        levelsDataFirebase[getlvlindex].isCompleted = true;
        print(
            "Scenario true but wrongisCorrect completed  Level with both $getlvlindex");
      }
    }
    if (isscenario == false) {
      levelsDataFirebase[getlvlindex].quizCompleted = false;
      print("Quiz not completed for Level $getlvlindex");
      if (levelsDataFirebase[getlvlindex].scenariosCompleted &&
          levelsDataFirebase[getlvlindex].quizCompleted == true) {
        levelsDataFirebase[getlvlindex].isCompleted = true;
        print(
            "Scenario false but wrongisCorrect completed  Level with both $getlvlindex");
      }
    }
  }
 */
  isCorrect
      ? showDialog(
          context: context,
          builder: (BuildContext context) {
            double baseWidth = 405;
            double fem = MediaQuery.of(context).size.width / baseWidth;
            double ffem = fem * 0.97;

            return Stack(
              children: [
                // Background overlay
                Container(
                  color:
                      Colors.black.withOpacity(0.5), // Adjust opacity as needed
                  width: double.infinity,
                  height: double.infinity,
                ),

                // AlertDialog
                AlertDialog(
                  content: coinEarnedsuccess(), // Your custom content here
                  contentPadding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.transparent, // Transparent background
                ),
              ],
            );
          },
        )
      : showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: WrongAnswerMessage(),
              contentPadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.transparent,
            );
          },
        );
}
