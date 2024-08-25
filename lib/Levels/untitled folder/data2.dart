import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resuscode/Levels/quiz.dart';

class LevelDataClass {
  final List<Map<String, String>> subLevels;
  final List<Map<String, dynamic>> scenarioData;
  //final Map<String, dynamic> quizData; // New field for quiz data
  bool isCompleted; // Indicates if the entire level is completed
  bool
      scenariosCompleted; // Indicates if all scenarios in the level are completed
  List<bool>
      multichoiceQuestionsCompleted; // Track completion status of multichoice questions

  LevelDataClass({
    required this.subLevels,
    required this.scenarioData,
    // required this.quizData,
    required this.isCompleted,
    required this.scenariosCompleted,
    required this.multichoiceQuestionsCompleted, // Add this field
  });
}

List<LevelDataClass> levelsDataFirebase = []; // Initialize it as an empty list

List<LevelDataClass> levelsDatalocal = [
  LevelDataClass(
    subLevels: [
      {
        'title': 'Identifying the Hazard',
        'subtitle':
            'Always be aware of wet or slippery surfaces in the kitchen.',
        'longDescription':
            '**Lesson : Identifying the Hazard**\n\n\nAlways be aware of wet or slippery surfaces in the kitchen. Water, spills, or grease can make the floor hazardous. \n Lesson : Keep the kitchen floor dry and clean to prevent slips and falls. Use rugs with anti-slip mats in high-risk areas.',
      },
      {
        'title': 'Immediate Response',
        'subtitle': 'If someone slips and falls, assess their condition.',
        'longDescription': '**Lesson : Identifying the Hazard**\n\n\n'
            'If someone slips and falls, assess their condition and call for help if needed.'
            '\n Lesson : If the person is conscious and able to move, assist them in getting up slowly and carefully. Encourage them to rest and observe for any signs of injury.'
      },
    ],
    scenarioData: [
      {
        'title': 'Ankle Sprain during Outdoor Sports',
        'subtitle':
            'Ayesha was doing the dishes in the kitchen when she accidentally spilled water on the floor. Jamal, not noticing the wet floor, enters the kitchen, slips on the wet surface, and falls. He is conscious but in pain. What immediate actions should Ayesha take to assist him?',
        'questions': [
          {
            'question': 'Help them up immediately',
            'options': [
              'a) Help them up immediately',
              'b) Assess the situation for any potential hazards',
              'c) Check for any visible injuries',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Jamal’s back is hurting',
            'options': [
              'a) Walk around to elevate pain',
              'b) Offer pain medication',
              'c) Stay still and avoid moving',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Jamal is in shock',
            'options': [
              'a) Elevate their legs and keep them warm',
              'b) Give them hot drink to help them relax',
              'c) Walk around to distract from shock',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Severe headache',
            'options': [
              'a) Give pain medication immediately',
              'b) Apply cold compress to the head',
              'c) Lie down with head elevated',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
        ],
      },
    ],
    multichoiceQuestionsCompleted: List.generate(4, (index) => false),
    isCompleted: false, // Level completion status (false by default)
    scenariosCompleted: false, // Scenario completion status (false by default)
  ),
  LevelDataClass(
    subLevels: [
      {
        'title': 'Choking incident in living room.',
        'subtitle':
            'Be cautious of small objects, especially for young children, as they pose a choking risk. Keep small items out of reach. \n ',
        'longDescription': '**Lesson : Recognizing Choking Hazards**\n\n\n'
            'Be cautious of small objects, especially for young children, as they pose a choking risk. Keep small items out of reach. \n '
            'Lesson :  Educate everyone in the household about potential choking hazards to promote awareness and prevent choking incidents.',
      },
      {
        'title': 'First Aid for Choking',
        'subtitle':
            'If someone is choking, prompt them to cough to attempt to clear the blockage. If they cant, perform the Heimlich maneuver (abdominal thrusts) to dislodge the object.',
        'longDescription': '**Lesson : Identifying the Hazard**\n\n\n'
            'If someone is choking, prompt them to cough to attempt to clear the blockage. If they cant, perform the Heimlich maneuver (abdominal thrusts) to dislodge the object.'
            '\n Lesson : Encourage learning basic first aid techniques, including the Heimlich maneuver, to be prepared for choking emergencies.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Ahmed, a toddler, was playing with small toys in the living room. He accidentally swallowed a small toy and started choking. His sister, Hira, noticed him struggling and alerted the family. What immediate actions should Hira and the family take to assist Ahmed and ensure his safety?',
        'questions': [
          {
            'question':
                'What immediate actions should Hira and the family take to assist Ahmed and ensure his safety?',
            'options': [
              'a) Offer him a glass of water',
              'b) Perform the Heimlich maneuver',
              'c) Pat him on the back',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'It is safe to attempt to remove an object from a choking person’s throat with your fingers.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Ahmad has partial blockage in their airway.',
            'options': [
              'a) Drink water to clear the blockage',
              'b) Standby until the blockage resolve on its own',
              'c) Perform Heimlich maneuver if necessary',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Airway obstruction cleared successfully',
            'options': [
              'a) Rest and recover',
              'b) Provide a meal or snack',
              'c) Offer some water',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
        ],
      },
    ],
    multichoiceQuestionsCompleted: List.generate(4, (index) => false),
    isCompleted: false, // Level completion status (false by default)
    scenariosCompleted: false, // Scenario completion status (false by default)
  ),
];
