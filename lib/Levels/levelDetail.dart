import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/colorToggle_provoder.dart';
import '../SuccessAndWrongDialog/coinearned.dart';

class LevelDetails extends StatefulWidget {
  final String title;
  final String subDescription;
  final int getsubindex;
  final int getlvlindex;
  LevelDetails({
    required this.title,
    required this.subDescription,
    required this.getsubindex,
    required this.getlvlindex,
  });

  @override
  _LevelDetailsState createState() => _LevelDetailsState();
}

class _LevelDetailsState extends State<LevelDetails> {
  // Timer for tracking how long the user spends on the page
  late Timer _readTimer;
  bool _pageRead = false;
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Start the timer when the page is loaded
    _startReadTimer(widget.getsubindex);
  }

  // Create an instance of UserOutlineDataService
  final UserOutlineDataService userOutlineDataService =
      UserOutlineDataService();

  void _startReadTimer(int getindex) {
    // Adjust the duration as needed (e.g., 2 minutes)
    _readTimer = Timer(const Duration(seconds: 2), () {
      // When the timer expires, mark the page as read
      setState(() {
        _pageRead = true;
      });
      print(
          'getlvlindex: ${widget.getlvlindex}, getsubindex: ${widget.getsubindex}');

      Provider.of<OutlineProvider>(context, listen: false)
          .toggleOutline(widget.getlvlindex, widget.getsubindex, true);

      if (currentUser != null) {
        final OutlineProvider outlineProvider =
            Provider.of<OutlineProvider>(context, listen: false);

        // Create a map to store outline status
        Map<String, bool> outlineStatusMap = {};

        // Generate the key for the unique level-sublevel combination
        String key = '${widget.getlvlindex}_${widget.getsubindex}';

        // Get the outline status for the specified level and sub-level
        bool status = outlineProvider.getOutlineStatus(
            widget.getlvlindex, widget.getsubindex);

        outlineStatusMap[key] = status;

        final UserOutlineData userOutlineData = UserOutlineData(
          userId: currentUser!.uid, // Replace with the actual user ID
          outlineStatusMap: outlineStatusMap,
        );

        userOutlineDataService.saveUserOutlineData(
            userOutlineData, '${widget.getlvlindex}_${widget.getsubindex}');
      }

      // Call the saveUserOutlineData method to store user outline data

      // Show the custom popup dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
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
                content: const coinEarnedsuccess(), // Your custom content here
                contentPadding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.transparent, // Transparent background
              ),
            ],
          );
        },
      );

      /*     showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setStateInsideDialog) {
              return Stack(
                children: [
                  // Background overlay
                  Container(
                    color: Colors.black
                        .withOpacity(0.5), // Adjust opacity as needed
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
                    backgroundColor:
                        Colors.transparent, // Transparent background
                  ),
                ],
              );
            },
          );
        },
      );
   */ /*  // Use a Future.delayed to schedule the state update after the build is complete
      Future.delayed(Duration.zero, () {
        // Use Provider to toggle the outline flag
        Provider.of<OutlineProvider>(context, listen: false)
            .toggleOutline(widget.getlvlindex, widget.getsubindex, true);
      }); */
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the page is disposed
    _readTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/background.png',
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 22 * fem),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white, // Change the color as needed
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10 * fem, 0, 0, 15 * fem),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.timmana(
                      fontSize: 23 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.6275 * ffem / fem,
                      letterSpacing: -0.46 * fem,
                      color: const Color(0xff00c2cb),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30 * fem),
                    gradient: const LinearGradient(
                      begin: Alignment(-4, -3.657),
                      end: Alignment(1.479, 1.371),
                      colors: <Color>[Color(0xffd9d9d9), Color(0x00d9d9d9)],
                      stops: <double>[0, 1],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x3f000000),
                        offset: Offset(0 * fem, 4 * fem),
                        blurRadius: 2 * fem,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20 * fem,
                    horizontal: 15 * fem,
                  ),
                  margin: const EdgeInsets.only(left: 0),
                  child: Text(
                    widget.subDescription,
                    style: GoogleFonts.thasadith(
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.3 * ffem / fem,
                      letterSpacing: -0.3 * fem,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*   final List<Map<String, String>> scenarioData = [
    {
      'title': 'Basic Life Support',
      'subdescription':
          '**Lesson 1: Basic Life Support for Kids**\n\n\nIn this lesson, we will explore the importance of Basic Life Support (BLS) skills for kids, teaching you how to respond when someone is unresponsive and not breathing. We will start by introducing CPR techniques, which involve chest compressions and rescue breaths. \n\n\n\nChest compressions are performed by pushing hard and fast on the center of the person\'s chest using both hands. We will guide you on the correct hand placement and demonstrate how to maintain a steady rhythm. \n\n\n\nRescue breaths are given by creating a seal over the person\'s mouth and nose, and then blowing gently into their lungs. We will explain the proper technique and emphasize the importance of checking for chest rise after each breath.\n\n\n\nYou will also learn how to assess if someone is unresponsive by gently shaking their shoulders and asking loudly if they are okay. If there is no response and they are not breathing, we will show you how to activate the emergency services and begin CPR immediately.\n\n\n\nBy the end of this lesson, you will have the knowledge and skills to confidently perform CPR, ensuring you can take action during a life-threatening situation. Remember, your quick response could make a difference and save a life!',
    },
    // Add more scenarios as needed
  ]; */