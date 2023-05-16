abstract class StAthletsScreen{}

class StAthletsScreenInit extends StAthletsScreen{}

class StAthletsScreenLoaded extends StAthletsScreen{}

class StAthletsScreenLoading extends StAthletsScreen{}

class StAthletsScreenNoAuthError extends StAthletsScreen{}

class StAthletsScreenNoInternetError extends StAthletsScreen {}

class StAthletsScreenError extends StAthletsScreen{
  final int? error;
  final String? message;
  StAthletsScreenError({this.error,this.message});
}
    