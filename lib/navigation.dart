import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resuscode/Coins/coins.dart';
import 'package:resuscode/Levels/totallevels.dart';
import 'package:resuscode/Profile/profileScreen.dart';
import 'package:resuscode/Stats/statsSreen.dart';
import 'Levels/congratspopup.dart';
import 'Levels/levels.dart';
import 'Login/login.dart';
import 'providers/navigation_provider.dart'; // Import the navigation provider

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<NavigationProvider>(
        builder: (context, navigationProvider, child) {
          return IndexedStack(
            index: navigationProvider.currentIndex,
            children: [
              //Login(), // Replace with your widget
              //    Levels(),
              LevelsMainScreen(),
              StatsScreen(),
              CoinScreen(),
              ProfileScreen(), // Change this to the appropriate page widget
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          color: Colors.black38,
          width: double.infinity,
          height: 62.53 * fem,
          child: Stack(
            children: [
              Container(
                width: 382 * fem,
                height: 62.53 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30 * fem),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildNavigationButton(
                      fem: fem,
                      icon: Icons.menu_book,
                      isSelected:
                          context.watch<NavigationProvider>().currentIndex == 0,
                      onPressed: () {
                        context.read<NavigationProvider>().setCurrentIndex(0);
                      },
                    ),
                    buildNavigationButton(
                      fem: fem,
                      icon: FontAwesomeIcons.chartPie,
                      isSelected:
                          context.watch<NavigationProvider>().currentIndex == 1,
                      onPressed: () {
                        context.read<NavigationProvider>().setCurrentIndex(1);
                      },
                    ),
                    buildNavigationButton(
                      fem: fem,
                      icon: FontAwesomeIcons.trophy,
                      isSelected:
                          context.watch<NavigationProvider>().currentIndex == 2,
                      onPressed: () {
                        context.read<NavigationProvider>().setCurrentIndex(2);
                      },
                    ),
                    buildNavigationButton(
                      fem: fem,
                      icon: Icons.person,
                      isSelected:
                          context.watch<NavigationProvider>().currentIndex == 3,
                      onPressed: () {
                        context.read<NavigationProvider>().setCurrentIndex(3);
                      },
                    ),
                    // Add similar buildNavigationButton calls for other icons
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavigationButton({
    required double fem,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        icon,
        size: isSelected ? 31 * fem : 27.13 * fem,
        color: isSelected ? Colors.teal : Colors.grey,
      ),
    );
  }
}
