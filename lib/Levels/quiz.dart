/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:resuscode/SuccessAndWrongDialog/wronganswer.dart';
import 'dart:ui';

import '../Coins/coins_provider.dart';
import '../SuccessAndWrongDialog/customDialogforSucessAndWrond.dart';
import '../SuccessAndWrongDialog/hintdialog.dart';
import '../SuccessAndWrongDialog/selectanswer.dart';
import '../timer/timecountdown.dart';
import '../utils.dart';
import '../SuccessAndWrongDialog/coinearned.dart';

class QuizQuestion {
  final String question, gettingHint;
  final List<String> options;
  final int correctOptionIndex;
  final int getlvlindex;
  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.gettingHint,
    required this.getlvlindex,
  });
}

class QuizPage extends StatefulWidget {
  final QuizQuestion quizQuestion;

  QuizPage({required this.quizQuestion});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late CountdownTimer _countdownTimer;
  String _timeText = '0:15';
  bool _isMounted = false; // Add a mounted flag

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Create an instance of CountdownTimer when the screen initializes
    _countdownTimer = CountdownTimer(context);
    _isMounted = true; // Widget is mounted
    _updateTimeText(); // Initial update
  }

  @override
  void dispose() {
    _countdownTimer.cancelTimer();
    _isMounted = false; // Widget is no longer mounted
    super.dispose();
  }

  // Method to update the time text and trigger a UI update
  void _updateTimeText() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isMounted) {
        setState(() {
          _timeText = _countdownTimer.getTimeText();
        });
      } else {
        timer.cancel(); // Cancel the timer if the widget is not mounted
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height, // Occupies full screen height
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/background.png',
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            padding:
                EdgeInsets.fromLTRB(7 * fem, 43 * fem, 7 * fem, 24.47 * fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      25 * fem, 10 * fem, 12 * fem, 0 * fem),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 10 * fem, 20 * fem, 15 * fem),
                          child: Text(
                            'Quiz',
                            style: TextStyle(
                              fontSize: 28 * ffem,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff00c2cb),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 10 * fem, 2 * fem, 0 * fem),
                        child: Text(
                          _timeText,
                          style: TextStyle(
                            fontSize: 28 * ffem,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        width: 31 * fem,
                        height: 31 * fem,
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 10 * fem, 18 * fem, 0 * fem),
                        child: Image.asset(
                          'assets/icon-timer.png',
                          width: 31 * fem,
                          height: 31 * fem,
                        ),
                      ),
                    ],
                  ),
                ),
                QuizQuestionCard(
                  getlvlindex: widget.quizQuestion.getlvlindex,
                  question: widget.quizQuestion.question,
                  options: widget.quizQuestion.options,
                  correctOptionIndex: widget.quizQuestion.correctOptionIndex,
                  getHint: widget.quizQuestion.gettingHint,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class QuizQuestionCard extends StatefulWidget {
  final String question, getHint;
  final List<String> options;
  final int correctOptionIndex;
  final int getlvlindex;

  QuizQuestionCard(
      {required this.question,
      required this.options,
      required this.correctOptionIndex,
      required this.getlvlindex,
      required this.getHint});

  @override
  _QuizQuestionCardState createState() => _QuizQuestionCardState();
}

class _QuizQuestionCardState extends State<QuizQuestionCard> {
  int selectedOptionIndex = -1;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    var fsize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 53 * fem),
      padding: EdgeInsets.fromLTRB(25 * fem, 42 * fem, 27 * fem, 20 * fem),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 59 * fem, 0 * fem),
                constraints: BoxConstraints(
                  maxWidth: 247 * fem,
                ),
                child: Text(
                  widget.question,
                  style: SafeGoogleFont(
                    'Thasadith',
                    fontSize: 20 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.3 * ffem / fem,
                    letterSpacing: -0.4 * fem,
                    fontStyle: FontStyle.italic,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Container(
                width: 33 * fem,
                height: 33 * fem,
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 33 * fem,
                    height: 33 * fem,
                    child: TextButton(
                      onPressed: () {
                        // Implement your hint button onPressed action here
                        showHintDialog(context, widget.getHint);
                        Provider.of<CoinProvider>(context, listen: false)
                            .deductCoins(10);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Image.asset(
                        'assets/icon-hint.png',
                        width: 27 * fem,
                        height: 27 * fem,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.options
                .asMap()
                .map(
                  (index, option) => MapEntry(
                    index,
                    Container(
                      padding: EdgeInsets.only(bottom: 10 * fem),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Radio(
                            value: index,
                            groupValue: selectedOptionIndex,
                            onChanged: (value) {
                              setState(() {
                                selectedOptionIndex = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              option,
                              style: SafeGoogleFont(
                                'Thasadith',
                                fontSize: 19 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3 * ffem / fem,
                                letterSpacing: -0.38 * fem,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin:
                    EdgeInsets.fromLTRB(25 * fem, 0 * fem, 40 * fem, 0 * fem),
                width: fsize.width / 3,
                height: 40 * fem,
                child: TextButton(
                  onPressed: () {
                    if (selectedOptionIndex == -1) {
                      // No answer selected, show a message
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          double baseWidth = 405;
                          double fem =
                              MediaQuery.of(context).size.width / baseWidth;
                          double ffem = fem * 0.97;
                          return AlertDialog(
                            content: SelectAnswerMessage(),
                            contentPadding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.transparent,
                          );
                        },
                      );
                    } else {
                      // Answer selected, check if it's correct
                      bool isCorrect =
                          selectedOptionIndex == widget.correctOptionIndex;
                      updateCompletionStatus(
                          isCorrect, widget.getlvlindex, false);

                      showResultDialog(
                          isCorrect, context, widget.getlvlindex, false);
                    }
                  },
                  child: const Text('Next',
                      style: TextStyle(fontSize: 20, color: Colors.amber)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizAppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final int labelsize;

  QuizAppButton(
      {required this.label, required this.onPressed, required this.labelsize});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    var fsize = MediaQuery.of(context).size;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: 170 * fem,
        height: 50 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20 * fem),
          color: Color(0xff00c2cb),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: labelsize * ffem,
              fontWeight: FontWeight.w400,
              color: Color(0xffffffff),
            ),
          ),
        ),
      ),
    );
  }
}
 */