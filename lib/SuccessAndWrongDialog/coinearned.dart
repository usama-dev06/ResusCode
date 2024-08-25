import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resuscode/Coins/coins_provider.dart';

class coinEarnedsuccess extends StatefulWidget {
  const coinEarnedsuccess({
    super.key,
  });

  @override
  State<coinEarnedsuccess> createState() => _coinEarnedsuccessState();
}

class _coinEarnedsuccessState extends State<coinEarnedsuccess> {
  @override
  void initState() {
    super.initState();

    // Schedule the call to addCoins after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CoinProvider>(context, listen: false).addCoins(10);
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
              'You Earned',
              style: GoogleFonts.timmana(
                fontSize: 40 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.6275 * ffem / fem,
                letterSpacing: -0.8 * fem,
                color: Color(0xffffaf40),
              ),
            ),
            SizedBox(height: 5 * fem),
            Text(
              '10 Coins',
              style: GoogleFonts.timmana(
                fontSize: 64 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.6275 * ffem / fem,
                letterSpacing: -1.28 * fem,
                color: Color(0xffffffff),
              ),
            ),
            SizedBox(height: 5 * fem),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/emoji-party-popper.png',
                  width: 93.36 * fem,
                  height: 95 * fem,
                ),
                SizedBox(width: 10 * fem),
                Image.asset(
                  'assets/icon-coin-large.png',
                  width: 69.82 * fem,
                  height: 71 * fem,
                ),
                SizedBox(width: 10 * fem),
                Image.asset(
                  'assets/emoji-party-popper.png',
                  width: 95 * fem,
                  height: 96.67 * fem,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
