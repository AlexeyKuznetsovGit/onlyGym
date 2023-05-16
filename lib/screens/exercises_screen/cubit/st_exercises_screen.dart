abstract class StExercisesScreen{}

class StExercisesScreenInit extends StExercisesScreen{}

class StExercisesScreenLoaded extends StExercisesScreen{}

class StExercisesScreenLoading extends StExercisesScreen{}

class StExercisesScreenNoAuthError extends StExercisesScreen{}

class StExercisesScreenNoInternetError extends StExercisesScreen {}

class StExercisesScreenError extends StExercisesScreen{
  final int? error;
  final String? message;
  StExercisesScreenError({this.error,this.message});
}
    