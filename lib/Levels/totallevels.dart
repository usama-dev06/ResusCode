import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resuscode/Levels/levels.dart';

import '../Coins/coins_provider.dart';
import '../providers/levelcompletion_provider.dart';
import '../providers/user_authprovider.dart';
import 'data.dart';

class levelsbox extends StatefulWidget {
  final int levelNo;
  final LevelDataClass levelindex;
  levelsbox({required this.levelNo, required this.levelindex});

  @override
  State<levelsbox> createState() => _levelsboxState();
}

class _levelsboxState extends State<levelsbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600), // Adjust the duration as needed
    );

    // Create a scaling animation
    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double referenceWidth = 405.0;
    double boxWidthFactor = 99.0 / referenceWidth;
    double boxHeightFactor = 95.51 / referenceWidth;
    double imageWidthFactor = 45.0 / referenceWidth;
    double imageHeightFactor = 45.0 / referenceWidth;

    int lvlnoForText = widget.levelNo + 1;
    final levelCompletionProvider = context.watch<LevelCompletionProvider>();

    // Check if the level is the first one or if it is completed
    bool isFirstLevel = widget.levelNo == 0;
    bool isCompleted = isFirstLevel ||
        levelCompletionProvider.isLevelCompleted(widget.levelNo);
    print("yesscommm $isCompleted");
    return GestureDetector(
      onTap: () {
        if (isCompleted) {
          // Level is completed or the first level, navigate to the level
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Levels(
              levelindex: widget.levelindex,
              levelNo: widget.levelNo,
            ),
          ));
        } else {
          // Level is not completed, show a message or handle accordingly
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You need to complete previous levels first.'),
            ),
          );
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: MediaQuery.of(context).size.width * boxWidthFactor,
              height: MediaQuery.of(context).size.width * boxHeightFactor,
              margin: const EdgeInsets.only(right: 16, bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment(-4, -3.657),
                  end: Alignment(1.479, 1.371),
                  colors: <Color>[Color(0xffd9d9d9), Color(0x00d9d9d9)],
                  stops: <double>[0, 1],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0, 4),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Level ${lvlnoForText}",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      letterSpacing: -0.38,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffffff),
                    ),
                  ),
                  if (!isCompleted) // Show lock icon if the level is not completed
                    Icon(
                      Icons.lock,
                      size: 32,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LevelsMainScreen extends StatefulWidget {
  @override
  State<LevelsMainScreen> createState() => _LevelsMainScreenState();
}

class _LevelsMainScreenState extends State<LevelsMainScreen> {
  // Function to fetch data from Firestore
  Future<List<LevelDataClass>> fetchLevelsDataFromFirestore() async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp();

      // Create a reference to the 'levels' collection
      CollectionReference levelsCollection =
          FirebaseFirestore.instance.collection('levels');

      QuerySnapshot querySnapshot = await levelsCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        List<LevelDataClass> levelsDataFirebase = [];

        for (var doc in querySnapshot.docs) {
          // Convert Firestore data to a LevelDataClass object
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          List<Map<String, String>> subLevels =
              (data['subLevels'] as List<dynamic>)
                  .map((item) => Map<String, String>.from(item))
                  .toList();

          List<Map<String, dynamic>> scenarioData =
              (data['scenarioData'] as List<dynamic>)
                  .map((item) => Map<String, dynamic>.from(item))
                  .toList();

          // Map<String, dynamic> quizData =
          //     Map<String, dynamic>.from(data['quizData']);

          LevelDataClass levelData = LevelDataClass(
            subLevels: subLevels,
            scenarioData: scenarioData,
            isCompleted: data['isCompleted'] ?? false,
            scenariosCompleted: data['scenariosCompleted'] ?? false,
            multichoiceQuestionsCompleted: List.generate(4, (index) => false),
          );

          levelsDataFirebase.add(levelData);
        }

        return levelsDataFirebase;
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
    }
    // Return an empty list if there's an error or no data
    return [];
  }

  Future<List<LevelDataClass>>? _levelsDataFuture; // Store the future

  @override
  void initState() {
    super.initState();

    // Fetch data from Firestore and update levelsData
    // Initialize the future once in initState
    _levelsDataFuture = fetchLevelsDataFromFirestore();

    // Initialize the LevelCompletionProvider and fetch completion status
    final userProvider = context.read<UserAuthProvider>();
    final levelCompletionProvider = context.read<LevelCompletionProvider>();

    // Ensure that the user is signed in before initializing
    if (userProvider.isAuthenticated) {
      levelCompletionProvider.init(userProvider.userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the relative dimensions based on a reference width.
    double referenceWidth = 405.0;
    double fem = MediaQuery.of(context).size.width / referenceWidth;
    double ffem = fem * 0.97;
    final coinProvider = Provider.of<CoinProvider>(context);

    UserAuthProvider userProvider = context.read<UserAuthProvider>();
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 23, 11, 24.47),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/background.png',
              ),
            ),
          ),
          child: FutureBuilder<List<LevelDataClass>>(
            future: _levelsDataFuture, // Use the stored future
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading spinner while fetching data
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Display an error message if an error occurs
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // Handle the case where no data is available
                return Text('No data available');
              } else {
                // Data has been successfully loaded
                List<LevelDataClass> levelsDataF = snapshot.data!;

                levelsDataFirebase = levelsDataF;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  width: fem * 35.63,
                                  height: fem * 35.63,
                                  child: Image.asset(
                                    'assets/icon-user-circle.png',
                                    width: fem * 9.63,
                                    height: fem * 9.63,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    userProvider.username!,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2575,
                                      letterSpacing: -0.38,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  15 * fem, 8 * fem, 12 * fem, 8 * fem),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30 * fem),
                                gradient: const LinearGradient(
                                  begin: Alignment(-4, -3.657),
                                  end: Alignment(1.479, 1.371),
                                  colors: <Color>[
                                    Color(0xffd9d9d9),
                                    Color(0x00d9d9d9)
                                  ],
                                  stops: <double>[0, 1],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
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
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 2, bottom: 10),
                      child: const Text(
                        'Levels',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          height: 1.6275,
                          letterSpacing: -0.56,
                          color: Color(0xff00c2cb),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 4, bottom: 23.49),
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(levelsDataF.length, (index) {
                          // Create a custom widget here to display each LevelData
                          return levelsbox(
                            levelNo: index, // You can customize the label
                            levelindex: levelsDataF[index],
                          );
                        }),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
