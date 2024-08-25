import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resuscode/providers/user_authprovider.dart';

import '../Coins/coins_provider.dart';
import '../providers/colorToggle_provoder.dart';
import 'data.dart';
import 'levelDetail.dart';
import 'quiz.dart';
import 'scenario.dart';

class Levels extends StatefulWidget {
  final LevelDataClass levelindex;
  final int levelNo;

  Levels({required this.levelindex, required this.levelNo});
  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  Stream<UserOutlineData?> userOutlineDataStream(
      String userId, String customDocId) {
    return FirebaseFirestore.instance
        .collection('user_outline_data')
        .doc(userId)
        .collection('custom_data')
        .doc(customDocId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        final outlineStatusMap =
            Map<String, bool>.from(userData['outlineStatusMap']);

        return UserOutlineData(
          userId: userId,
          outlineStatusMap: outlineStatusMap,
        );
      } else {
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    final coinProvider = Provider.of<CoinProvider>(context);
    /*  OutlineProvider outlineProvider = context.read<OutlineProvider>();
    outlineProvider.initializeOutlineStatusLists(levelsData);
 */
    OutlineProvider outlineProvider = context.read<OutlineProvider>();

    UserAuthProvider userProvider = context.read<UserAuthProvider>();
    userProvider.username;
/* // Initialize outline status for levelsData[0]
    outlineProvider.initializeOutlineStatusList(
        0, widget.levelindex.subLevels.length); */

    List<Map<String, String>> subLevels = widget.levelindex.subLevels;
    List<Map<String, dynamic>> scenarioData = widget.levelindex.scenarioData;
    //   Map<String, dynamic> quizData = widget.levelindex.quizData;
    //print("aaaa ${levelsData[0]}");
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(7 * fem, 44 * fem, 7 * fem, 24.47 * fem),
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/background.png',
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(15 * fem, 5 * fem, 0 * fem, 0 * fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15 * fem),
                    child: Text(
                      'Level ${widget.levelNo + 1}',
                      style: GoogleFonts.timmana(
                        fontSize: 25 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.6275 * ffem / fem,
                        letterSpacing: -0.5 * fem,
                        color: const Color(0xff00c2cb),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        15 * fem, 5 * fem, 12 * fem, 8 * fem),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 19 * fem),
                          child: Text(
                            'Coins : ${coinProvider.coins}',
                            style: GoogleFonts.thasadith(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.3 * ffem / fem,
                              letterSpacing: -0.3 * fem,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 19 * fem,
                          height: 19.32 * fem,
                          child: Image.asset(
                            'assets/icon-coin.png',
                            width: 19 * fem,
                            height: 19.32 * fem,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 0 * fem), // Add spacing between header and cards
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height *
                    0.476, // Adjust the height as needed
                child: ListView.builder(
                  itemCount: subLevels.length, // Use the length of subLevels
                  itemBuilder: (context, index) {
                    return Consumer<OutlineProvider>(
                      builder: (context, outlineProvider, child) {
                        /*      bool isOutlineEnabled =
                            outlineProvider.getOutlineStatus(index);
     */
                        /*     bool isOutlineEnabled = outlineProvider
                            .getOutlineStatus(widget.levelNo, index); */
                        // Create an instance of UserOutlineDataService
                        bool isOutlineEnabled = false;
                        /* 
                        final UserOutlineDataService userOutlineDataService =
                            UserOutlineDataService();
// Load user outline data and update isOutlineEnabled
                        Future<void> loadUserOutline(String Keyplease) async {
                          final userId = FirebaseAuth.instance.currentUser!
                              .uid; // Replace with the actual user ID
                          final userOutlineData =
                              await userOutlineDataService.loadUserOutlineData(
                                  userId, Keyplease);
                          if (mounted) {
                            if (userOutlineData != null) {
                              final outlineStatusMap =
                                  userOutlineData.outlineStatusMap;
                              final key =
                                  '${widget.levelNo}_${index}'; // Unique identifier for this level-sublevel combination

                              // Check if the key exists in the map and extract the status
                              if (outlineStatusMap.containsKey(key)) {
                                isOutlineEnabled = outlineStatusMap[key] ??
                                    false; // Use false as a default value if it's null
                                print(
                                    "working $isOutlineEnabled and key is $key");
                              }
                            }
                            // Set the new value of isOutlineEnabled here
                            // This ensures that the UI gets updated with the loaded data
                            setState(() {});
                          }
                        }

// Call loadUserOutline when the widget is built
                        loadUserOutline('${widget.levelNo}_${index}'); */

                        return StreamBuilder<UserOutlineData?>(
                          stream: userOutlineDataStream(
                              FirebaseAuth.instance.currentUser!.uid,
                              '${widget.levelNo}_${index}'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              final userOutlineData = snapshot.data;
                              if (userOutlineData != null) {
                                final outlineStatusMap =
                                    userOutlineData.outlineStatusMap;
                                final key = '${widget.levelNo}_${index}';

                                if (outlineStatusMap.containsKey(key)) {
                                  isOutlineEnabled =
                                      outlineStatusMap[key] ?? false;
                                  print(
                                      "working $isOutlineEnabled and key is $key");
                                }
                              }

                              return ReusableCard(
                                title: subLevels[index]['title']!,
                                subTitle: subLevels[index]['subtitle']!,
                                fem: fem,
                                ffem: ffem,
                                hasYellowOutline: isOutlineEnabled,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LevelDetails(
                                      getlvlindex: widget.levelNo,
                                      getsubindex: index,
                                      title: subLevels[index]['title']!,
                                      subDescription: subLevels[index]
                                          ['longDescription']!,
                                    ),
                                  ));
                                },
                              );
                            } else {
                              // Return a loading indicator or placeholder widget while data is being fetched.
                              return const CircularProgressIndicator(); // You can replace this with a more suitable widget.
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(21 * fem, 0 * fem, 0 * fem, 0 * fem),
              child: Text(
                'Scenario',
                style: GoogleFonts.timmana(
                  fontSize: 25 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.6275 * ffem / fem,
                  letterSpacing: -0.5 * fem,
                  color: const Color(0xff167c26),
                ),
              ),
            ),
            ReusableCard(
              title: scenarioData[0]['title'] as String,
              subTitle: scenarioData[0]['subtitle'] as String,
              fem: fem,
              ffem: ffem,
              hasYellowOutline: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScenarioPage(
                      getsubtitile: scenarioData[0]['subtitle'],
                      getlvlindex: widget.levelNo,
                      scenarioQuestions: scenarioData[0]['questions']
                          .map<ScenarioQuestion>((questionData) {
                        return ScenarioQuestion(
                          getlvlindex: widget.levelNo,
                          question: questionData['question'] as String,
                          gettinghintmsg: questionData['hint'] as String,
                          options: List<String>.from(
                              questionData['options'] as List<dynamic>),
                          correctOptionIndex:
                              questionData['correctOptionIndex'] as int,
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final double fem;
  final double ffem;
  final bool hasYellowOutline;
  final VoidCallback onTap;

  const ReusableCard({
    required this.title,
    required this.subTitle,
    required this.fem,
    required this.hasYellowOutline,
    required this.ffem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 11 * fem),
        child: Container(
          width: double.infinity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate the maximum height based on available space
              double maxHeight = constraints.maxHeight;

              return Container(
                constraints: BoxConstraints(
                  minHeight: 113 * fem, // Minimum height to maintain
                  maxHeight:
                      maxHeight, // Maximum height based on available space
                ),
                padding: EdgeInsets.fromLTRB(
                  15 * fem,
                  19 * fem,
                  15 * fem,
                  20 * fem,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        hasYellowOutline ? Colors.yellow : Colors.transparent,
                    width: 2.0,
                  ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 4 * fem),
                      child: Text(
                        title,
                        style: GoogleFonts.timmana(
                          fontSize: 19 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.6275 * ffem / fem,
                          letterSpacing: -0.38 * fem,
                          color: const Color(0xff00c2cb),
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 326 * fem,
                      ),
                      child: Text(
                        subTitle,
                        style: GoogleFonts.thasadith(
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3 * ffem / fem,
                          letterSpacing: -0.3 * fem,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
