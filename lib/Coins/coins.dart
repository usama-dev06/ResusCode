import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/user_authprovider.dart';
import 'coins_provider.dart';

class CoinBox extends StatefulWidget {
  final int amount;

  CoinBox({
    required this.amount,
  });

  @override
  State<CoinBox> createState() => _CoinBoxState();
}

class _CoinBoxState extends State<CoinBox> with SingleTickerProviderStateMixin {
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

    return GestureDetector(
      onTap: () {
        // Trigger the animations when tapped
        _controller.forward().then((_) {
          _controller.reverse(); // Reverse the animation
        });
        Provider.of<CoinProvider>(context, listen: false)
            .addCoins(widget.amount);
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
                gradient: const LinearGradient(
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
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    width: MediaQuery.of(context).size.width * imageWidthFactor,
                    height:
                        MediaQuery.of(context).size.width * imageHeightFactor,
                    child: Image.asset(
                      'assets/icon-coin.png',
                      width: MediaQuery.of(context).size.width * 0.08,
                      height: MediaQuery.of(context).size.width * 0.0815,
                    ),
                  ),
                  Text(
                    widget.amount.toString(),
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      letterSpacing: -0.38,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffffff),
                    ),
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

class CoinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define the relative dimensions based on a reference width.
    double referenceWidth = 405.0;
    double fem = MediaQuery.of(context).size.width / referenceWidth;
    double ffem = fem * 0.97;
    final coinProvider = Provider.of<CoinProvider>(context);
    UserAuthProvider userProvider = context.read<UserAuthProvider>();
    return Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                //    margin: const EdgeInsets.only(right: 303),
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
                            style: const TextStyle(
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
                'Daily Reward',
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
                children: [
                  CoinBox(amount: 10),
                  CoinBox(amount: 20),
                  CoinBox(amount: 30),
                  CoinBox(amount: 40),
                  CoinBox(amount: 50),
                  CoinBox(amount: 60),
                  CoinBox(amount: 90),
                  CoinBox(amount: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
