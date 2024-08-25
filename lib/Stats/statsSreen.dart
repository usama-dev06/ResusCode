import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../Levels/data.dart';
import '../providers/user_authprovider.dart';
import 'level_stats.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    UserAuthProvider userProvider = context.read<UserAuthProvider>();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user_completion_data')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('levels')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is loading, you can show a loading indicator.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Calculate statistics based on the snapshot data
          double completedLevels = 0;
          double completedScenarios = 0;
          double totalLevels = levelsDataFirebase.length.toDouble();
          double totalScenarios = levelsDataFirebase.length.toDouble();
          print("total level are $totalLevels...$totalScenarios");
          snapshot.data!.docs.forEach((doc) {
            final docData = doc.data() as Map<String, dynamic>;
            if (docData['isCompleted']) {
              completedLevels++;
            }
            if (docData['scenariosCompleted']) {
              completedScenarios++;
            }
          });
          print(
              "completed total level are $completedLevels...$completedScenarios");

          double levelsPercentage = (completedLevels / totalLevels) * 100;
          double scenariosPercentage =
              (completedScenarios / totalScenarios) * 100;

          List<PieChartSectionData> sections = [
            PieChartSectionData(
              color: const Color(0xfff8b250),
              value: levelsPercentage.roundToDouble(),
              title: 'Level Completion',
              radius: 90 * fem,
              titleStyle: TextStyle(
                fontSize: 14 * ffem,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
            ),
            PieChartSectionData(
              color: const Color(0xff845bef),
              value: scenariosPercentage.roundToDouble(),
              title: 'Scenarios',
              radius: 90 * fem,
              titleStyle: TextStyle(
                fontSize: 14 * ffem,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
            ),
            PieChartSectionData(
              color: Color.fromARGB(255, 85, 141, 170),
              value: 100 - scenariosPercentage.roundToDouble(),
              title: 'Remaining ',
              radius: 90 * fem,
              titleStyle: TextStyle(
                fontSize: 14 * ffem,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
            ),
          ];

          // Now you can use the levelsPercentage and scenariosPercentage in your UI
          return Container(
            width: double.infinity,
            child: Container(
              padding:
                  EdgeInsets.fromLTRB(7 * fem, 23 * fem, 7 * fem, 24.47 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background.png'),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        11 * fem, 20 * fem, 0 * fem, 31 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 8 * fem, 0 * fem),
                          width: 39 * fem,
                          height: 39 * fem,
                          child: Image.asset(
                            'assets/icon-user-circle.png',
                            width: 39 * fem,
                            height: 39 * fem,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 5 * fem, 0 * fem, 0 * fem),
                          child: Text(
                            userProvider.username!,
                            style: TextStyle(
                              fontSize: 19 * ffem,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.38 * fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 53 * fem),
                    padding: EdgeInsets.fromLTRB(
                        108 * fem, 80 * fem, 86 * fem, 42.88 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30 * fem),
                      gradient: LinearGradient(
                        begin: Alignment(-4, -3.657),
                        end: Alignment(1.479, 1.371),
                        colors: <Color>[Color(0xffd9d9d9), Color(0x00d9d9d9)],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 24.59 * fem),
                          width: 217 * fem,
                          height: 215.41 * fem,
                          child: PieChart(
                            PieChartData(
                              startDegreeOffset: 320,
                              sections: sections,
                              borderData: FlBorderData(show: false),
                              centerSpaceRadius: 2,
                              sectionsSpace: 5,
                              pieTouchData: PieTouchData(
                                touchCallback: null,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 19 * fem, 9 * fem),
                          constraints: BoxConstraints(
                            maxWidth: 118 * fem,
                          ),
                          child: Text(
                            '${levelsPercentage.round()}% Levels\n${scenariosPercentage.round()}% Scenarios',
                            style: TextStyle(
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.48 * fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
