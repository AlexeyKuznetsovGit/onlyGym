abstract class StAuthScreen{}

class StAuthScreenInit extends StAuthScreen{}

class StAuthScreenLoaded extends StAuthScreen{}

class StAuthScreenLoading extends StAuthScreen{}

class StAuthScreenNoAuthError extends StAuthScreen{}

class StAuthScreenNoInternetError extends StAuthScreen {}

class StAuthScreenError extends StAuthScreen{
  final int? error;
  final String? message;
  StAuthScreenError({this.error,this.message});
}
    