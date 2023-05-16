abstract class StCurrentExercisesScreen{}

class StCurrentExercisesScreenInit extends StCurrentExercisesScreen{}

class StCurrentExercisesScreenLoaded extends StCurrentExercisesScreen{}

class StCurrentExercisesScreenLoading extends StCurrentExercisesScreen{}

class StCurrentExercisesScreenNoAuthError extends StCurrentExercisesScreen{}

class StCurrentExercisesScreenNoInternetError extends StCurrentExercisesScreen {}

class StCurrentExercisesScreenError extends StCurrentExercisesScreen{
  final int? error;
  final String? message;
  StCurrentExercisesScreenError({this.error,this.message});
}
    