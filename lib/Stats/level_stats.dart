// Calculate the total number of levels
import '../Levels/data.dart';
// Export the calculated values
export 'level_stats.dart';
/* 
// Calculate the total number of levels
int totalLevels = levelsData.length;

// Calculate the total number of scenarios and quizzes
int totalScenarios = levelsData.fold(
    0,
    (previousValue, levelData) =>
        previousValue + (levelData.scenarioData?.length ?? 0));
int totalQuizzes = levelsData.fold(
    0,
    (previousValue, levelData) =>
        previousValue + (levelData.quizData != null ? 1 : 0));

// Calculate the number of completed levels
int completedLevels = levelsData.where((level) => level.isCompleted).length;

// Calculate the number of completed scenarios
int completedScenarios = levelsData.fold(
  0,
  (previousValue, levelData) =>
      previousValue + (levelData.scenariosCompleted ? 1 : 0),
);

// Calculate the number of completed quizzes
int completedQuizzes = levelsData.fold(
  0,
  (previousValue, levelData) =>
      previousValue + (levelData.quizCompleted ? 1 : 0),
);

// Calculate completion percentages
double levelCompletionPercentage = (completedLevels / totalLevels) * 100;
double scenarioCompletionPercentage =
    (completedScenarios / totalScenarios) * 100;
double quizCompletionPercentage = (completedQuizzes / totalQuizzes) * 100;
 */