abstract class StProfileScreen{}

class StProfileScreenInit extends StProfileScreen{}

class StProfileScreenLoaded extends StProfileScreen{}

class StProfileScreenLoading extends StProfileScreen{}

class StProfileScreenNoAuthError extends StProfileScreen{}

class StProfileScreenNoInternetError extends StProfileScreen {}

class StProfileScreenError extends StProfileScreen{
  final int? error;
  final String? message;
  StProfileScreenError({this.error,this.message});
}
    