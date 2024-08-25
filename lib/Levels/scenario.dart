import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resuscode/Levels/data.dart';
import 'package:resuscode/SuccessAndWrongDialog/hintdialog.dart';
import 'package:resuscode/SuccessAndWrongDialog/selectanswer.dart';

import '../Coins/coins_provider.dart';
import '../SuccessAndWrongDialog/customDialogforSucessAndWrond.dart';
import '../SuccessAndWrongDialog/wronganswer.dart';
import '../providers/levelcompletion_provider.dart';
import '../providers/user_authprovider.dart';
import '../timer/timecountdown.dart';
import '../utils.dart';
import 'quiz.dart';

class ScenarioQuestion {
  final String question, gettinghintmsg;
  final List<String> options;
  final int correctOptionIndex;
  final int getlvlindex;

  ScenarioQuestion({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.gettinghintmsg,
    required this.getlvlindex,
  });
}

class CustomPageController extends PageController {
  bool canScroll = true;

  @override
  bool get hasClients => super.hasClients;

  @override
  void attach(ScrollPosition position) {
    super.attach(position);
    position.isScrollingNotifier.addListener(_handleScrolling);
  }

  @override
  void detach(ScrollPosition position) {
    position.isScrollingNotifier.removeListener(_handleScrolling);
    super.detach(position);
  }

  void _handleScrolling() {
    if (position.isScrollingNotifier.value) {
      if (!canScroll) {
        position.correctBy(0);
      }
    }
  }
}

class ScenarioPage extends StatefulWidget {
  final List<ScenarioQuestion> scenarioQuestions;
  final String getsubtitile;
  final int getlvlindex;

  ScenarioPage({
    required this.scenarioQuestions,
    required this.getsubtitile,
    required this.getlvlindex,
  });

  @override
  State<ScenarioPage> createState() => _ScenarioPageState();
}

class _ScenarioPageState extends State<ScenarioPage> {
  //final PageController _pageController = PageController();
  int currentPage = 0;
  late CountdownTimer _countdownTimer;
  String _timeText = '0:60';
  bool _isMounted = false;
  late List<bool> answers;
  bool isCurrentQuestionAnswered = false;
  late CustomPageController _pageController; // Use CustomPageController

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    answers = List.generate(
        widget.scenarioQuestions.length, (index) => false); // Track answers
    _pageController = CustomPageController();

    _countdownTimer = CountdownTimer(context);
    _isMounted = true;
    _updateTimeText();
    _updateMultichoiceQuestionsStatus(); // Add this line
  }

  @override
  void dispose() {
    _pageController.dispose();
    _countdownTimer.cancelTimer();
    _isMounted = false;
    super.dispose();
  }

  void _updateTimeText() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isMounted) {
        setState(() {
          _timeText = _countdownTimer.getTimeText();
        });
      } else {
        timer.cancel();
      }
    });
  }

// Inside _updateMultichoiceQuestionsStatus method:
  void _updateMultichoiceQuestionsStatus() {
    if (!answers.contains(false) &&
        widget.scenarioQuestions.length ==
            widget.scenarioQuestions
                .where((question) => question.correctOptionIndex != -1)
                .length) {
      // All questions are answered and correct
      int lvlIndex = widget.getlvlindex;
      levelsDatalocal[lvlIndex].multichoiceQuestionsCompleted =
          List.generate(widget.scenarioQuestions.length, (index) => true);

      if (levelsDatalocal[lvlIndex]
          .multichoiceQuestionsCompleted
          .every((completed) => completed)) {
        // All multichoice questions in this level are completed
        levelsDatalocal[lvlIndex].isCompleted = true;

        // Check if all levels are completed
        if (levelsDatalocal.every((level) => level.isCompleted)) {
          // All levels are completed, show level complete message
          showLevelCompleteDialog(context);
        }
      }
    }

    // Print the number of questions answered correctly and how many are left
    int questionsAnswered = answers.where((answer) => answer).length;
    int questionsLeft = widget.scenarioQuestions.length - questionsAnswered;
    print('Questions mu answered correctly: $questionsAnswered');
    print('Question mu s left: $questionsLeft');
  }

// Inside onAnswerSelected method:
  void onAnswerSelected(bool isCorrect) {
    print('onAnswerSelected called'); // Add this line

    setState(() {
      answers[currentPage - 1] = isCorrect;
      isCurrentQuestionAnswered = isCorrect;
    });

    // Update the multichoice questions completion status
    _updateMultichoiceQuestionsStatus();

    if (!answers.contains(false)) {
      // showLevelCompleteDialog(context);

      updateCompletionStatus(widget.getlvlindex);
      // Initialize the LevelCompletionProvider and fetch completion status
      final userProvider = context.read<UserAuthProvider>();
      final levelCompletionProvider = context.read<LevelCompletionProvider>();
      // Mark level 2 as completed for the currently authenticated user

      levelCompletionProvider.markLevelCompleted(
          widget.getlvlindex + 1, userProvider.userId!);
      showResultDialog(isCorrect, context, widget.getlvlindex, true);
    }

    // Print the number of questions answered correctly and how many are left
    int questionsAnswered = answers.where((answer) => answer).length;
    int questionsLeft = widget.scenarioQuestions.length - questionsAnswered;
    print('Questions answered correctly: $questionsAnswered');
    print('Questions left: $questionsLeft');
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/background.png'),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(25 * fem, 10 * fem, 12 * fem, 0 * fem),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 20 * fem, 20 * fem, 15 * fem),
                        child: Text(
                          'Scenario Quiz',
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
                          0 * fem, 20 * fem, 2 * fem, 0 * fem),
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
                          0 * fem, 20 * fem, 18 * fem, 0 * fem),
                      child: Image.asset(
                        'assets/icon-timer.png',
                        width: 31 * fem,
                        height: 31 * fem,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics:
                      AlwaysScrollableScrollPhysics(), // Disable automatic scrolling
                  onPageChanged: (page) {
                    setState(() {
                      print("current $page");
                      currentPage = page;
                      // Check if the current question is answered
                      if (page >= 1 &&
                          page <= widget.scenarioQuestions.length) {
                        isCurrentQuestionAnswered = answers[page - 1];
                      } else {
                        isCurrentQuestionAnswered = false;
                      }
                    });
                  },
                  itemCount: widget.scenarioQuestions.length +
                      1, // +1 for the subtitle page
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Subtitle page
                      return ScenarioSubtitleCard(
                        subtitle: widget.getsubtitile,
                        onNextQuestion: () {
                          // Removed the automatic scrolling here
                        },
                      );
                    } else {
                      // Question page
                      final questionIndex = index - 1;
                      final question = widget.scenarioQuestions[questionIndex];

                      return ScenarioQuestionCard(
                        getlvlindex: question.getlvlindex,
                        question: question.question,
                        options: question.options,
                        correctOptionIndex: question.correctOptionIndex,
                        pageIndex: questionIndex + 1,
                        getHint: question.gettinghintmsg,
                        onNextQuestion: () {
                          // Removed the automatic scrolling here
                        },
                        onAnswerSelected: (isCorrect) {
                          /*    setState(() {
                            answers[questionIndex] = isCorrect;
                          });

                          // Check if all answers are correct
                          if (!answers.contains(false)) {
                            // All answers are correct, show level complete message
                            showLevelCompleteDialog(context);
                            updateCompletionStatus(
                                isCorrect, widget.getlvlindex, true);
                          } else {
                            // Scroll to the next question manually here
                            _pageController.animateToPage(
                              currentPage + 1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          } */
                          onAnswerSelected(
                              isCorrect); // Call the provided onAnswerSelected method
                        },
                      );
                    }
                  },
                ),
              ),
              buildPageIndicator(widget.scenarioQuestions.length + 1),
            ],
          ),
        ),
      ),
    );
  }

  void showLevelCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Level Complete'),
          content: Text('Congratulations! You have completed the level.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget buildPageIndicator(int pageCount) {
    List<Widget> indicators = [];

    for (int i = 0; i < pageCount; i++) {
      indicators.add(
          i == currentPage ? activePageIndicator() : inactivePageIndicator());
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  Widget activePageIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget inactivePageIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class ScenarioSubtitleCard extends StatelessWidget {
  final String subtitle;
  final VoidCallback onNextQuestion;

  ScenarioSubtitleCard({
    required this.subtitle,
    required this.onNextQuestion,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 53 * fem),
        padding: EdgeInsets.fromLTRB(25 * fem, 42 * fem, 27 * fem, 20 * fem),
        width: double.infinity,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 347 * fem,
              ),
              child: Text(
                subtitle,
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
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  55 * fem,
                  195 * fem,
                  55 * fem,
                  0 * fem,
                ),
                child: TextButton(
                  onPressed: onNextQuestion,
                  child: const Text(
                    'Next -->',
                    style: TextStyle(fontSize: 20, color: Colors.amber),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// The ScenarioQuestionCard remains unchanged
// ScenarioQuestionCard widget
class ScenarioQuestionCard extends StatefulWidget {
  final String question, getHint;
  final List<String> options;
  final int correctOptionIndex;
  final int pageIndex;
  final int getlvlindex;
  final VoidCallback onNextQuestion;
  final void Function(bool) onAnswerSelected;

  ScenarioQuestionCard({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.pageIndex,
    required this.getlvlindex,
    required this.getHint,
    required this.onNextQuestion,
    required this.onAnswerSelected,
  });

  @override
  _ScenarioQuestionCardState createState() => _ScenarioQuestionCardState();
}

class _ScenarioQuestionCardState extends State<ScenarioQuestionCard> {
  int selectedOptionIndex = -1;
  bool questionCompleted = false;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 405;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 53 * fem),
        padding: EdgeInsets.fromLTRB(25 * fem, 42 * fem, 27 * fem, 20 * fem),
        width: double.infinity,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
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

            // Render hint button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 33 * fem,
                  height: 33 * fem,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 33 * fem,
                      height: 33 * fem,
                      child: TextButton(
                        onPressed: () {
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

            // Render options
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.options.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                return Container(
                  padding: EdgeInsets.only(top: 10 * fem),
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
                );
              }).toList(),
            ),

            GestureDetector(
              onTap: () {
                if (selectedOptionIndex == -1) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
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
                  bool isCorrect =
                      selectedOptionIndex == widget.correctOptionIndex;
                  widget.onAnswerSelected(isCorrect);

                  if (isCorrect) {
                    setState(() {
                      questionCompleted = true;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: WrongAnswerMessage(),
                          contentPadding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.transparent,
                        );
                      },
                    );
                  }
                }
              },
              child: Container(
                margin:
                    EdgeInsets.fromLTRB(55 * fem, 20 * fem, 55 * fem, 0 * fem),
                child: Text(
                  questionCompleted ? 'Next -->' : 'Check Answer',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
