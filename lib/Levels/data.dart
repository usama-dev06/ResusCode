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
            'question':
                'What immediate actions should Ayesha take to assist him?',
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
  LevelDataClass(
    subLevels: [
      {
        'title': 'Electrical shock in home',
        'subtitle':
            'Always exercise caution around electrical appliances and outlets to prevent electrical shocks. \n ',
        'longDescription': '**Lesson : Electrical Safety Awareness**\n\n\n'
            'Always exercise caution around electrical appliances and outlets to prevent electrical shocks. \n '
            'Lesson :   Educate everyone in the household about the dangers of playing with electrical cords or tampering with electrical equipment.',
      },
      {
        'title': 'First Aid for Electrical Shock',
        'subtitle':
            ' In the event of an electrical shock, immediately turn off the power source, if possible, and call for emergency assistance.',
        'longDescription': '**Lesson : \n\n\n'
            ' In the event of an electrical shock, immediately turn off the power source, if possible, and call for emergency assistance.'
            '\n Lesson : Do not touch the person directly; instead, use a non-conductive object like a dry wooden stick to carefully move them away from the source of the shock.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Rehan was attempting to fix a faulty electrical outlet in the living room when he received a sudden electrical shock. His wife, Amina, saw the incident and realized he was in distress. What immediate actions should Amina take to assist Rehan and ensure his safety?',
        'questions': [
          {
            'question':
                'What immediate actions should Amina take to assist Rehan and ensure his safety?',
            'options': [
              'a) Immediately touch the person to pull him away from source',
              'b) Pour water on the person to stop electric current',
              'c) Call emergency and use wooden rod to pull him awa',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'You should touch the person while they are in contact with the source of electricity.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Rehan is no longer in contact with source.',
            'options': [
              'a) Check the person’s breathing and start CPR',
              'b) Apply a cooling gel or cream to affected areas',
              'c) Examine the person’s clothes for burn marks',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Rehan has burns on his hands.',
            'options': [
              'a) Apply a sterile dressing to the burns',
              'b) Rinse the burns with cold water',
              'c) Pop any blisters that have formed',
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
  LevelDataClass(
    subLevels: [
      {
        'title': 'Vomiting',
        'subtitle':
            'Recognize the signs of discomfort or nausea, which may indicate an impending vomiting episode. \n ',
        'longDescription': '**Lesson : Recognizing Signs of Distress**\n\n\n'
            'Recognize the signs of discomfort or nausea, which may indicate an impending vomiting episode. \n '
            'Lesson :  Be mindful of triggers like strong odors, certain foods, or motion that can induce vomiting.',
      },
      {
        'title': ' First Aid for Vomiting',
        'subtitle':
            'If someone is about to vomit, help them move to a safe, open area where they wont choke on the vomit.',
        'longDescription': '**Lesson : \n\n\n'
            'If someone is about to vomit, help them move to a safe, open area where they wont choke on the vomit..'
            '\n Lesson : Stay with the person and provide reassurance and support during and after the vomiting episode.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Fatima started feeling nauseous after having lunch due to a reaction to a new medication. She rushed to the living room, feeling the urge to vomit. Her friend, Sara, noticed her distress and offered assistance. What immediate actions should Sara take to assist Fatima and ensure her safety during the vomiting episode?',
        'questions': [
          {
            'question': 'What is vomiting?',
            'options': [
              'a) The involuntary expulsion of stomach contents through mouth',
              'b) The inability to swallow food or fluids properly',
              'c) A sudden feeling of dizziness',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Immediately stop from vomiting by any means.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Provide initial first aid.',
            'options': [
              'a) Offer small sips of water',
              'b) Avoid giving the person solid foods',
              'c) Both',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'When should Fatima seek medical help',
            'options': [
              'a) If vomiting is persistent with abdominal pain',
              'b) If signs of dehydration like decreased urine output and dry mouth',
              'c) Both',
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
        'title': 'Nosebleeds in hot weather',
        'subtitle':
            'Learn how hot weather can dry out nasal passages, making them more prone to nosebleeds. \n ',
        'longDescription':
            '**Lesson : Understanding Nosebleeds and Climate Impact**\n\n\n'
                'Learn how hot weather can dry out nasal passages, making them more prone to nosebleeds. \n '
                'Lesson :  Understand the importance of staying hydrated and keeping the nasal passages moisturized, especially in hot weather.',
      },
      {
        'title': 'First Aid for Nosebleeds',
        'subtitle':
            'When experiencing a nosebleed, tilt the head slightly forward to avoid swallowing blood. Pinch the nostrils together and breathe through the mouth.',
        'longDescription': '**Lesson : \n\n\n'
            'When experiencing a nosebleed, tilt the head slightly forward to avoid swallowing blood. Pinch the nostrils together and breathe through the mouth.'
            '\n Lesson : Apply a cold compress to the back of the neck or on the nose to help constrict blood vessels and slow down the bleeding.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Zahra was outside on a hot summer day when she suddenly experienced a nosebleed due to the dry air. Her cousin, Imran, noticed the situation and rushed to her aid. What immediate actions should Imran take to assist Zahra and manage the nosebleed in the hot weather?',
        'questions': [
          {
            'question': 'What is the reason of nosebleeds in hot weather?',
            'options': [
              'a) Increased blood flow to the nasal blood vessel due to heat',
              'b) Dry and warm air causing the nasal membranes to become dry and fragile',
              'c) Excessive sweating leading to dehydration',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'Tilting the head back is the correct position to control a nosebleed.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Help Zahra',
            'options': [
              'a) Pinch the soft part of nostrils together with thumb and index finger',
              'b) Apply a cold compress or ice pack to the bridge of nose',
              'c) Both',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'When should Zahra seek medical help',
            'options': [
              'a) If nosebleed lasts for more than 20 minutes',
              'b) If there is excessive blood loss',
              'c) Both',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'It is important to be hydrated and avoid excessive heat exposure.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
        ],
      },
    ],
    multichoiceQuestionsCompleted: List.generate(5, (index) => false),
    isCompleted: false, // Level completion status (false by default)
    scenariosCompleted: false, // Scenario completion status (false by default)
  ),
  LevelDataClass(
    subLevels: [
      {
        'title': 'Toothache Troubles',
        'subtitle':
            'Good dental health is essential for overall well-being.  \n ',
        'longDescription': '**Lesson : Dental Health Awareness**\n\n\n'
            'Good dental health is essential for overall well-being. Maintaining proper oral hygiene helps prevent toothaches and other dental problems. \n '
            'Lesson :  Regularly brush your teeth using fluoride toothpaste and a soft-bristle toothbrush. Dont forget to floss daily to remove food particles between your teeth.',
      },
      {
        'title': 'First Aid for Toothache',
        'subtitle':
            'Rinse your mouth with warm water to clean it and use dental floss to remove any trapped food or debris that may be causing the pain.',
        'longDescription': '**Lesson : \n\n\n'
            'Rinse your mouth with warm water to clean it and use dental floss to remove any trapped food or debris that may be causing the pain.'
            '\n Lesson : Over-the-counter pain relievers like ibuprofen can help alleviate the pain temporarily. Follow the recommended dosage instructions.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Sofia was enjoying her evening when suddenly she felt a sharp, throbbing pain in her lower right jaw. She realized it was a toothache. Shes in discomfort and doesnt know what to do. How can Sofia effectively manage her toothache to get some relief?',
        'questions': [
          {
            'question': 'What is common cause of toothache?',
            'options': [
              'a) Tooth decay or cavities',
              'b) Gum disease or gingivities',
              'c) Tooth fractures or cracks',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'How can you provide temporary relief?',
            'options': [
              'a) Rinse the mouth with warm saltwater',
              'b) Apply an icepack on the cheek',
              'c) Both',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'When should i seek medical help',
            'options': [
              'a) If the pain persist for 2 hours',
              'b) If there is swelling or pus around the affected area',
              'c) If brushing hurt your tooth',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'Placing aspirin directly on the affected tooth can help relieve a toothache.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
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
        'title': 'Earache Emergency',
        'subtitle':
            'Taking care of your ears is essential to prevent earaches and hearing problems. \n ',
        'longDescription': '**Lesson : Ear Health Awareness**\n\n\n'
            'Taking care of your ears is essential to prevent earaches and hearing problems. \n '
            'Lesson:   Protect your ears from loud noises by using earplugs or earmuffs when exposed to high decibel levels. \n '
            'Lesson :  Avoid inserting objects like cotton swabs or fingers into your ear canal, as this can damage the delicate structures inside.',
      },
      {
        'title': 'First Aid for Ear Pain',
        'subtitle':
            'Earaches can be caused by various factors, including infections or changes in air pressure. Knowing how to alleviate the pain is crucial.',
        'longDescription': '**Lesson : \n\n\n'
            'Earaches can be caused by various factors, including infections or changes in air pressure. Knowing how to alleviate the pain is crucial.'
            '\n Lesson : If you or someone you know experiences sudden ear pain, avoid inserting anything into the ear. Instead, keep the ear dry and clean.'
            '\n Lesson : Over-the-counter pain relievers, such as acetaminophen or ibuprofen, can help manage the pain. Follow the recommended dosage instructions.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Alex had just returned from a flight and started experiencing intense ear pain. The change in air pressure during the flight left him with an earache. What can Alex do to relieve the pain and discomfort in his ear?',
        'questions': [
          {
            'question': 'What is the reason of ear pain?',
            'options': [
              'a) Ear infection or otitis media',
              'b) Earwax blockage',
              'c) Injury or trauma to the ear',
              'd) All',
            ],
            'correctOptionIndex': 3,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'How will you provide temporary relief?',
            'options': [
              'a) Apply a warm compress to the affected area',
              'b) Use pain relievers like ibuprofen',
              'c) Avoid exposure to loud noises',
              'd) All',
            ],
            'correctOptionIndex': 3,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'It is safe to use cotton swabs to clean ear if experiencing ear pain.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'How can you prevent ear pain in future?',
            'options': [
              'a) Insert objects into the ear canal to clean the ear',
              'b) Keep ears clean and dry after swimming and bathing',
              'c) Dont seek treatment for ear infections',
              'd) All',
            ],
            'correctOptionIndex': 1,
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
        'title': 'Spice accident',
        'subtitle':
            'Kitchen safety is paramount to prevent accidents, especially when dealing with spices and hot ingredients. \n ',
        'longDescription': '**Lesson : Kitchen Safety**\n\n\n'
            'Kitchen safety is paramount to prevent accidents, especially when dealing with spices and hot ingredients. \n '
            'Lesson :  Always handle spices with care, and be aware of their potency. Spices can add flavor, but they can also cause harm if mishandled.',
      },
      {
        'title': 'First Aid for Spice Accidents',
        'subtitle':
            'Accidentally inhaling or getting spicy substances in your eyes or on your skin can be painful. Knowing how to react is crucial.',
        'longDescription': '**Lesson : Identifying the Hazard**\n\n\n'
            'Accidentally inhaling or getting spicy substances in your eyes or on your skin can be painful. Knowing how to react is crucial.'
            '\n Lesson : If you inhale or accidentally swallow a very spicy substance, drink milk or eat yogurt to soothe the burn.'
            '\n Lesson : If you get spices in your eyes, rinse them gently with cold water for at least 15 minutes. Seek medical attention if irritation persists.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'At a spicy noodle challenge, Sarah thought she could handle the fiery reaper noodles. As she took a bite, the intense heat overwhelmed her. Sweat poured down her face, and she struggled to catch her breath, regretting the underestimated challenge. What should Sarah do now? ',
        'questions': [
          {
            'question':
                'Ingesting a large amount of spicy food can cause immediate health hazards.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'What should Sarah do if she ingest a particularly spicy spice?',
            'options': [
              'a) Drink a glass of water to wash down spiciness',
              'b) Eat something bland or dairy based',
              'c) Monitor the symptoms as the spiciness gradually subsides',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'How will you treat spice burns on the skin?',
            'options': [
              'a) Rinse the affected area with cool water for several minutes',
              'b) Apply icepack to reduce pain and swelling',
              'c) Cover the burn with a clean, non-stick dressing',
              'd) All',
            ],
            'correctOptionIndex': 3,
            'hint': 'Hint hereeeee',
          },
        ],
      },
    ],
    multichoiceQuestionsCompleted: List.generate(3, (index) => false),
    isCompleted: false, // Level completion status (false by default)
    scenariosCompleted: false, // Scenario completion status (false by default)
  ),
  LevelDataClass(
    subLevels: [
      {
        'title': 'Fall from roof or out of window',
        'subtitle':
            'Safety in and around your home is crucial to prevent accidents like falls from roofs or windows. \n ',
        'longDescription': '**Lesson : Home Safety**\n\n\n'
            'Safety in and around your home is crucial to prevent accidents like falls from roofs or windows. \n '
            'Lesson :  Keep windows secure with screens or locks to prevent accidental falls, especially in homes with children.',
      },
      {
        'title': 'First Aid for Falls',
        'subtitle':
            'Falls from heights can result in serious injuries. Knowing how to respond is essential.',
        'longDescription': '**Lesson : \n\n\n'
            'Falls from heights can result in serious injuries. Knowing how to respond is essential.'
            '\n Lesson : If you witness someone fall from a roof or window, immediately call 1122 or your local emergency number.'
            '\n Lesson : Avoid moving the injured person unless they are in immediate danger, as moving them incorrectly could worsen their injuries.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Liam was on the roof of his house, cleaning the gutters, when he lost his balance and fell to the ground below. His neighbor, Emma, saw the accident and rushed over. What steps should Emma take to assist Liam and ensure his safety until help arrives?',
        'questions': [
          {
            'question': 'What should be the first action?',
            'options': [
              'a) Assess the persons responsiveness and breating',
              'b) Call for emergency medical assistance',
              'c) Ensure the safety of all the area to prevent further accidents',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'It is safe to move someone who has fallen from a roof immediately.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'How can you provide initial first aid?',
            'options': [
              'a) Keep the person still and stabilize their head and neck',
              'b) Apply pressure to any bleeding wounds to control bleeding',
              'c) Keep the person calm until medical help arrives',
              'd) All',
            ],
            'correctOptionIndex': 3,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'It is important to prevent the person from moving or attempting to move until medical professional arrive.',
            'options': [
              'a) True',
              'b) False',
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
  LevelDataClass(
    subLevels: [
      {
        'title': 'Splinter',
        'subtitle':
            'Splinters are small, foreign objects that can get embedded in the skin. They are usually made of wood, glass, metal, or plastic. \n ',
        'longDescription': '**Lesson : Understanding Splinters**\n\n\n'
            'Splinters are small, foreign objects that can get embedded in the skin. They are usually made of wood, glass, metal, or plastic. \n '
            'Lesson :  Splinters can be painful and may lead to infection if not removed properly and promptly.',
      },
      {
        'title': 'First Aid for Splinters',
        'subtitle':
            'If you or someone you know gets a splinter, its important to know how to handle it safely.',
        'longDescription': '**Lesson : \n\n\n'
            'If you or someone you know gets a splinter, its important to know how to handle it safely.'
            '\n Lesson : Use clean tweezers to gently grasp the exposed end of the splinter and pull it out in the same direction it entered the skin.'
            '\n Lesson : After removing the splinter, clean the area with soap and water, apply an antiseptic, and cover it with a bandage to prevent infection.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Mia was playing in the garden when she accidentally brushed against a wooden fence, and a tiny wood splinter got stuck in her finger. Shes in pain and doesnt know what to do. How can Mia safely remove the splinter and take care of her injured finger?',
        'questions': [
          {
            'question': 'What is a Splinter?',
            'options': [
              'a) A small cut or abrasion on the skin',
              'b) A foreign abject embedded in the skin',
              'c) A bacterial infection in a wound',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'It is recommended to remove a splinter immediately after it occurs, regardless of its size or location.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'What should be the first action?',
            'options': [
              'a) Wash your hands thoroughly to prevent infection',
              'b) Sterilize a pair of tweezers or splinter removal tools',
              'c) Examine the area around for signs of inflammation',
              'd) All',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'How to remove splinter from the skin?',
            'options': [
              'a) Clean the area around splinter with mild soap and water',
              'b) Use clean tweezers to grasp splinter',
              'c) Gently pull the splinter in same direction it entered the skin',
              'c) All',
            ],
            'correctOptionIndex': 3,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'After removing, clean the wound and apply adhesive bandage.',
            'options': [
              'a) True',
              'b) False',
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
  LevelDataClass(
    subLevels: [
      {
        'title': 'Sprain',
        'subtitle':
            'A sprain is an injury to a ligament, which is the tissue that connects bones to other bones. \n ',
        'longDescription': '**Lesson : Understanding Sprains**\n\n\n'
            'A sprain is an injury to a ligament, which is the tissue that connects bones to other bones. \n '
            'Lesson :  Sprains can occur when a joint is forced to move beyond its normal range of motion, often resulting in pain, swelling, and limited mobility.',
      },
      {
        'title': 'First Aid for Sprains',
        'subtitle':
            'Knowing how to provide immediate first aid for a sprain is important to reduce pain and prevent further damage.',
        'longDescription': '**Lesson : \n\n\n'
            'Knowing how to provide immediate first aid for a sprain is important to reduce pain and prevent further damage.'
            '\n Lesson :  Rest the injured area, elevate it if possible, and apply ice wrapped in a cloth for 15-20 minutes to reduce swelling.'
            '\n Lesson :  Compress the area with a bandage to provide support and reduce swelling, but avoid wrapping it too tightly.'
            '\n Lesson :  Over-the-counter pain relievers can help manage pain and inflammation; follow the recommended dosage.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Jake was playing basketball when he landed awkwardly after a jump, twisting his ankle. He felt immediate pain and noticed his ankle was swollen. What should Jake do to provide initial care for his sprained ankle and prevent further complications?',
        'questions': [
          {
            'question': 'What is a Sprain?',
            'options': [
              'a) An injury to bones of a joint',
              'b) An injury to ligaments of a joint',
              'c) An injury to the muscles of a joint',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'What is the first action you should take?',
            'options': [
              'a) Apply ice to the affected area to reduce swelling',
              'b) Immobilize the joint and keep it elevated',
              'c) Assess the severity of sprain',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'It is recommended to apply heat to a fresh sprain.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'How to apply first aid?',
            'options': [
              'a) Apply a cold compress to injured area',
              'b) Rest and elevate injured joint',
              'c) Apply a compression bandage',
              'c) All',
            ],
            'correctOptionIndex': 3,
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
        'title': 'Heavy object fall on person',
        'subtitle':
            'Being cautious around heavy objects is crucial to prevent accidents and injuries. \n ',
        'longDescription': '**Lesson : Safety Around Heavy Objects**\n\n\n'
            ' Being cautious around heavy objects is crucial to prevent accidents and injuries. \n '
            'Lesson :  Always ensure that heavy objects are properly secured and stored to avoid accidental falls.',
      },
      {
        'title': 'First Aid for Heavy Object Injuries',
        'subtitle':
            'In the event of a heavy object falling on someone, knowing how to respond quickly can be lifesaving.',
        'longDescription': '**Lesson : \n\n\n'
            'In the event of a heavy object falling on someone, knowing how to respond quickly can be lifesaving.'
            '\n Lesson :  Call 1122 or your local emergency number immediately to request professional medical assistance.'
            '\n Lesson :  While waiting for help, try to carefully assess the situation and provide reassurance to the injured person.'
            '\n Lesson :  Do not attempt to lift the heavy object off the person unless it is safe to do so and you have the necessary equipment and strength.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Olivia was in her garage rearranging some heavy boxes on a high shelf when one of the boxes accidentally fell, hitting her on the shoulder and pinning her against the wall. Her neighbor, Daniel, heard the noise and rushed to her aid. What steps should Daniel take to assist Olivia and ensure her safety until professional help arrives?',
        'questions': [
          {
            'question': 'What should be the first action?',
            'options': [
              'a) Assess the persons responsiveness and call for medical help',
              'b) Remove the heavy object from persons body quickly',
              'c) Stabilize the persons neck and head',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'It is safe to move a person immediately after heavy object has fallen.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'How to assess persons injuries?',
            'options': [
              'a) Look for visible signs of injury such as bleeding or deformities',
              'b) Ask them about their level of pain',
              'c) Check for difficulty in breathing or movement',
              'd) All',
            ],
            'correctOptionIndex': 3,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'How to provide initial first aid?',
            'options': [
              'a) Apply pressure to any bleeding wounds',
              'b) Keep the person moving to identify fractures',
              'c) Ask the person to be normal',
              'c) All',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'It is important to monitor pulse and breathing while waiting for medical help.',
            'options': [
              'a) True',
              'b) False',
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
  LevelDataClass(
    subLevels: [
      {
        'title': 'Knife cut in Kitchen',
        'subtitle':
            'Safety in the kitchen is essential to prevent accidents like knife cuts. \n ',
        'longDescription': '**Lesson : Kitchen Safety**\n\n\n'
            ' Safety in the kitchen is essential to prevent accidents like knife cuts. \n '
            'Lesson :  Always handle knives with caution, keeping them sharp and clean, and store them properly when not in use.',
      },
      {
        'title': 'First Aid for Knife Cuts',
        'subtitle':
            'Knife cuts can happen in the kitchen. Knowing how to respond promptly is crucial.',
        'longDescription': '**Lesson : \n\n\n'
            'Knife cuts can happen in the kitchen. Knowing how to respond promptly is crucial.'
            '\n Lesson :  If you or someone you know gets a knife cut, start by washing your hands and the wound with soap and water to reduce the risk of infection.'
            '\n Lesson :  Apply gentle pressure with a clean cloth or bandage to stop the bleeding. If the cut is deep, you may need to seek professional medical attention.'
            '\n Lesson :  Keep the injured area elevated to reduce swelling.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Amna was preparing dinner when she accidentally cut her finger while chopping vegetables. Blood started to flow from the cut, and she was in pain. What should Sarah do to properly care for her knife cut and stop the bleeding?',
        'questions': [
          {
            'question': 'What should be the first action?',
            'options': [
              'a) Stop bleeding by applying direct pressure',
              'b) Rinse the wound with clean water',
              'c) Assess the depth of the cut',
              'd) All',
            ],
            'correctOptionIndex': 0,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'It is recommended to use tourniquet to control bleeding.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'How to clean and care for cut?',
            'options': [
              'a) Do not wash wound with mild soap and water',
              'b) Apply an antibiotic ointment',
              'c) Cover the cut with kitchen handkerchief',
              'd) All',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'What should you avoid doing?',
            'options': [
              'a) Using adhesive tape indirectly',
              'b) Note the signs of infection like redness or puss',
              'c) Continue kitchen activities without hand hygiene',
              'c) All',
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
        'title': 'Burn injury in a room',
        'subtitle':
            'Being aware of fire hazards and knowing how to prevent fires is essential for home safety. \n ',
        'longDescription': '**Lesson : Fire Safety Awareness**\n\n\n'
            ' Being aware of fire hazards and knowing how to prevent fires is essential for home safety. \n '
            'Lesson :  Keep flammable materials away from heat sources, and never leave cooking or heating appliances unattended.',
      },
      {
        'title': 'First Aid for Burns',
        'subtitle':
            'Burns can happen in various situations. Knowing how to provide immediate care for burns is crucial.',
        'longDescription': '**Lesson : \n\n\n'
            'Burns can happen in various situations. Knowing how to provide immediate care for burns is crucial.'
            '\n Lesson :  In the event of a burn injury, the first step is to cool the burn under cold, running water for at least 10 minutes to reduce pain and prevent further tissue damage.'
            '\n Lesson :  Cover the burn with a clean, non-stick bandage or cloth and seek professional medical attention, especially for severe burns or burns on sensitive areas like the face, hands, or genitals.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Michael was in his room when he accidentally knocked over a candle, causing a fire. He tried to put out the flames and sustained a burn on his forearm. The room filled with smoke, making it difficult to see. What should Michael do to treat his burn injury and safely escape the room during the fire?',
        'questions': [
          {
            'question': 'What should be the first action?',
            'options': [
              'a) Apply ice directly to the burn',
              'b) Immediately remove any clothing stuck to burn',
              'c) Run cool water over the burn for 10 minutes',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'It is safe to apply butter or oil to a burn injury.',
            'options': [
              'a) True',
              'b) False',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'Michaels burn injury appears to be severe with blisters.',
            'options': [
              'a) Pop the blister ',
              'b) Cover the burn loosely with non-stick dressing',
              'c) Rub the burn gently ',
              'd) All',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'Michael is experiencing pain.',
            'options': [
              'a) Apply a cold pack directly to the burn',
              'b) Administer over the counter pain medication',
              'c) Seek medical assistance',
              'c) All',
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
        'title': 'Poisoned in laundry room',
        'subtitle':
            'Ensuring the safety of your household is essential to prevent accidents and poisoning incidents. \n ',
        'longDescription': '**Lesson : Household Safety**\n\n\n'
            ' Ensuring the safety of your household is essential to prevent accidents and poisoning incidents. \n '
            'Lesson :  Keep potentially toxic substances, such as cleaning products and chemicals, securely stored in their original containers and out of reach of children and pets.',
      },
      {
        'title': 'First Aid for Poisoning',
        'subtitle':
            'Recognizing the signs of poisoning and knowing how to respond is critical to saving lives.',
        'longDescription': '**Lesson : \n\n\n'
            'Recognizing the signs of poisoning and knowing how to respond is critical to saving lives.'
            '\n Lesson :  If someone is suspected of ingesting a poisonous substance, call your local poison control center or emergency services immediately.'
            '\n Lesson :  Do not try to induce vomiting unless instructed by a medical professional. In some cases, this can worsen the situation.'
            '\n Lesson :  Try to identify the substance ingested and provide this information to the medical professionals for accurate treatment.'
      },
    ],
    scenarioData: [
      {
        'title': 'Accident Scenario:',
        'subtitle':
            'Lisa was doing laundry in the laundry room when she noticed her child, Ethan, with an open bottle of detergent. She found the bottle empty and realized that Ethan might have ingested some of it. Ethan began to show signs of distress. What should Lisa do to respond to this poisoning incident and help her child before professional medical help arrives?',
        'questions': [
          {
            'question': 'What should be the first action?',
            'options': [
              'a) Induce vomiting immediately',
              'b) Call emergency service',
              'c) Give the person something to eat or drink',
            ],
            'correctOptionIndex': 1,
            'hint': 'Hint hereeeee',
          },
          {
            'question': 'What should Lisa do now?',
            'options': [
              'a) Offer a glass of milk',
              'b) Induce vomiting',
              'c) Place Ethan in recovery position and monitor his breathing',
            ],
            'correctOptionIndex': 2,
            'hint': 'Hint hereeeee',
          },
          {
            'question':
                'Activated charcoal can be used as a home remedy for poisoning.',
            'options': [
              'a) True ',
              'b) False',
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

Future<void> uploadLevelsDataToFirestore() async {
  try {
    final firebaseApp = Firebase.app();

    // Reference to the Firestore collection for levels data
    final levelsCollection = FirebaseFirestore.instance.collection('levels');

    for (int i = 0; i < levelsDatalocal.length; i++) {
      await levelsCollection.add({
        'subLevels': levelsDatalocal[i].subLevels,
        'scenarioData': levelsDatalocal[i].scenarioData,
        'isCompleted': levelsDatalocal[i].isCompleted,
        'scenariosCompleted': levelsDatalocal[i].scenariosCompleted,
        'multichoiceQuestionsCompleted':
            levelsDatalocal[i].multichoiceQuestionsCompleted,
      });
      print("Level $i Uploaded");
    }

    print('Levels data uploaded to Firestore successfully!');
  } catch (e) {
    print('Error uploading levels data to Firestore: $e');
  }
}


/* Future<void> uploadLevelsDataToFirestore() async {
  try {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Create a reference to the 'levels' collection
    CollectionReference levelsCollection =
        FirebaseFirestore.instance.collection('levels');

    // Query the latest document based on a timestamp field (e.g., 'updatedAt')
    QuerySnapshot querySnapshot = await levelsCollection
        .orderBy('updatedAt', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // No existing data or first time upload
      print('No existing data. Uploading data to Firestore.');

      for (int i = 0; i < levelsData.length; i++) {
        // Add an 'updatedAt' timestamp to each document
        levelsData[i].quizData['updatedAt'] = FieldValue.serverTimestamp();

        await levelsCollection.add({
          'subLevels': levelsData[i].subLevels,
          'scenarioData': levelsData[i].scenarioData,
          'quizData': levelsData[i].quizData,
          'isCompleted': levelsData[i].isCompleted,
          'scenariosCompleted': levelsData[i].scenariosCompleted,
          'quizCompleted': levelsData[i].quizCompleted,
        });
      }

      print('Data uploaded to Firestore successfully!');
    } else {
      // Compare the 'updatedAt' timestamp to check for changes
      Timestamp lastUpdateTime = querySnapshot.docs.first['updatedAt'];

      if (lastUpdateTime
          .toDate()
          .isBefore(DateTime.now().subtract(Duration(days: 1)))) {
        // Data needs to be updated (e.g., if it's older than 1 day)
        print('Data needs to be updated. Uploading new data to Firestore.');

        // Clear the existing data (delete old documents)
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        // Upload new data
        for (int i = 0; i < levelsData.length; i++) {
          // Add an 'updatedAt' timestamp to each document
          levelsData[i].quizData['updatedAt'] = FieldValue.serverTimestamp();

          await levelsCollection.add({
            'subLevels': levelsData[i].subLevels,
            'scenarioData': levelsData[i].scenarioData,
            'quizData': levelsData[i].quizData,
            'isCompleted': levelsData[i].isCompleted,
            'scenariosCompleted': levelsData[i].scenariosCompleted,
            'quizCompleted': levelsData[i].quizCompleted,
          });
        }

        print('Data updated in Firestore successfully!');
      } else {
        // Data is up to date, no changes needed
        print('Data is up to date in Firestore. No update needed.');
      }
    }
  } catch (e) {
    print('Error uploading data to Firestore: $e');
  }
}

 */




