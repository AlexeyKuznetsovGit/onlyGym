abstract class StTrainScreen{}

class StTrainScreenInit extends StTrainScreen{}

class StTrainScreenLoaded extends StTrainScreen{}

class StTrainScreenLoading extends StTrainScreen{}

class StTrainScreenNoAuthError extends StTrainScreen{}

class StTrainScreenNoInternetError extends StTrainScreen {}

class StTrainScreenError extends StTrainScreen{
  final int? error;
  final String? message;
  StTrainScreenError({this.error,this.message});
}
    