import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resuscode/Login/login.dart';

import 'package:resuscode/navigation.dart';

import 'Coins/coins_provider.dart';
import 'Levels/data.dart';
import 'providers/colorToggle_provoder.dart';
import 'providers/levelcompletion_provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/user_authprovider.dart';
import 'utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Check if the user is logged in
  User? currentUser = FirebaseAuth.instance.currentUser;

  // Create a provider for user authentication
  final userAuth = UserAuthProvider();

  // Initialize the user ID
  if (currentUser != null) {
    userAuth.initializeUser(currentUser.uid, currentUser.displayName ?? "");
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
          create: (context) => NavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CoinProvider(),
        ),
        ChangeNotifierProvider<UserAuthProvider>.value(value: userAuth),
        // Other providers that depend on user authentication can be conditionally created here
        if (currentUser != null)
          ChangeNotifierProvider(
            create: (context) =>
                OutlineProvider(currentUser.uid, levelsDataFirebase),
          ),

        ChangeNotifierProvider<LevelCompletionProvider>.value(
            value: LevelCompletionProvider()), // Add LevelCompletionProvider
        // Add more providers here as needed
      ],
      child: MyApp(currentUser: currentUser),
    ),
  );
}

class MyApp extends StatelessWidget {
  final User? currentUser;

  MyApp({required this.currentUser});
  @override
  Widget build(BuildContext context) {
    //  uploadLevelsDataToFirestore();
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // body: SingleChildScrollView(child: Levels()),

        //  body: Levels(),
        // body: levelDetails(),
        // body: EarnedCoinMain(),

        //  body: HomePage(),
        body: currentUser != null ? HomePage() : Login(),
      ),

      //2 3
      /*   home: Scaffold(
        body: Scene(),
      ), */
      //home: Scene(),
    );
  }
}
