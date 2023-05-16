abstract class StDiaryScreen{}

class StDiaryScreenInit extends StDiaryScreen{}

class StDiaryScreenLoaded extends StDiaryScreen{}

class StDiaryScreenLoading extends StDiaryScreen{}

class StDiaryScreenNoAuthError extends StDiaryScreen{}

class StDiaryScreenNoInternetError extends StDiaryScreen {}

class StDiaryScreenError extends StDiaryScreen{
  final int? error;
  final String? message;
  StDiaryScreenError({this.error,this.message});
}
    