abstract class StTimerScreen{}

class StTimerScreenInit extends StTimerScreen{}

class StTimerScreenLoaded extends StTimerScreen{}

class StTimerScreenLoading extends StTimerScreen{}

class StTimerScreenNoAuthError extends StTimerScreen{}

class StTimerScreenNoInternetError extends StTimerScreen {}

class StTimerScreenError extends StTimerScreen{
  final int? error;
  final String? message;
  StTimerScreenError({this.error,this.message});
}
    