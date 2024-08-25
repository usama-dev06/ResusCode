import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HintMessage extends StatelessWidget {
  const HintMessage({Key? key, required this.hintmsg}) : super(key: key);

  final String hintmsg;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      height: 200 * fem,
      child: Container(
        width: 391 * fem,
        height: 202 * fem,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hintmsg,
                style: GoogleFonts.timmana(
                  fontSize: 20 * ffem,
                  fontWeight: FontWeight.w400,
                  // height: 1.6275 * ffem / fem,
                  // letterSpacing: -0.8 * fem,
                  color: Color.fromARGB(
                      208, 209, 205, 189), // Red color for wrong answer
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showHintDialog(BuildContext context, String hint) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: HintMessage(
          hintmsg: hint,
        ),
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.transparent,
      );
    },
  );
}
