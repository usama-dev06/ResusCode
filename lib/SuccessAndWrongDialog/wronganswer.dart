import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Coins/coins_provider.dart';

class WrongAnswerMessage extends StatefulWidget {
  const WrongAnswerMessage({
    Key? key,
  }) : super(key: key);

  @override
  State<WrongAnswerMessage> createState() => _WrongAnswerMessageState();
}

class _WrongAnswerMessageState extends State<WrongAnswerMessage> {
  @override
  void initState() {
    super.initState();

    // Schedule the call to addCoins after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CoinProvider>(context, listen: false).deductCoins(10);
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      height: 367 * fem,
      child: Container(
        width: 391 * fem,
        height: 202 * fem,
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Wrong Answer',
              style: GoogleFonts.timmana(
                fontSize: 40 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.6275 * ffem / fem,
                letterSpacing: -0.8 * fem,
                color: Color(0xffff4040), // Red color for wrong answer
              ),
            ),
            SizedBox(height: 5 * fem),
            Text(
              '😢', // Sad emoji
              style: TextStyle(
                fontSize: 64 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.6275 * ffem / fem,
                letterSpacing: -1.28 * fem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
