abstract class NewsStates {}

class NewsIntialStates extends NewsStates {}

class NewsBottomNavStates extends NewsStates {}

//bussiness
class GetBusinessSuccess extends NewsStates {}

class GetBusinessError extends NewsStates {
  final String error;
  GetBusinessError(this.error);
}

class GetBusinessLoading extends NewsStates {}

//Sports
class GetSportsSuccess extends NewsStates {}

class GetSportsError extends NewsStates {
  final String error;
  GetSportsError(this.error);
}

class GetSportsLoading extends NewsStates {}

//Science
class GetScienceSuccess extends NewsStates {}

class GetScienceError extends NewsStates {
  final String error;
  GetScienceError(this.error);
}

class GetScienceLoading extends NewsStates {}

//Technology
class GetTechnologySuccess extends NewsStates {}

class GetTechnologyError extends NewsStates {
  final String error;
  GetTechnologyError(this.error);
}

class GetTechnologyLoading extends NewsStates {}

//Health
class GetHealthSuccess extends NewsStates {}

class GetHealthError extends NewsStates {
  final String error;
  GetHealthError(this.error);
}

class GetHealthLoading extends NewsStates {}

//Search
class GetSearchSuccess extends NewsStates {}

class GetSearchError extends NewsStates {
  final String error;
  GetSearchError(this.error);
}

class GetSearchLoading extends NewsStates {}

//changeMode
class ChangeModeStates extends NewsStates {}
